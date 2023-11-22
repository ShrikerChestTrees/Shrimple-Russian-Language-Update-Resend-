#define CLOUD_STEPS 24
#define CLOUD_SHADOW_STEPS 4
//#define CLOUD_CUBED

const int CloudOctaves = 3;
const float CloudScatterF = mix(0.72, 0.36, rainStrength);
const float CloudAbsorbF  = mix(0.14, 0.32, rainStrength);
const float CloudFar = mix(1200.0, far, rainStrength);
const float CloudHeight = 128.0;
const float CloudSize = 10.0;


float SampleCloudOctaves(const in vec3 worldPos) {
    float sampleD = 0.0;

    for (int octave = 0; octave < CloudOctaves; octave++) {
        float scale = exp2(CloudOctaves + 2 - octave);

        vec3 testPos = worldPos / CloudSize;

        #ifdef CLOUD_CUBED
            testPos = floor(testPos);
        #endif

        testPos /= scale;

        float sampleF = textureLod(texClouds, testPos.xzy / 8.0 * (octave+1), 0).r;
        sampleD += _pow3(sampleF) * rcp(exp2(octave));
    }

    const float sampleMax = 1.0 - rcp(exp2(CloudOctaves));
    sampleD /= sampleMax;

    float z = saturate(worldPos.y / CloudHeight);
    z = pow(z - z*z, 0.5) * 2.0;
    sampleD *= z;

    sampleD = smoothstep(mix(0.36, 0.09, rainStrength), 1.0, sampleD);

    return sampleD;
}

void GetCloudNearFar(const in vec3 worldPos, const in vec3 localViewDir, out vec3 cloudNear, out vec3 cloudFar) {
    float cloudOffset = cloudHeight - worldPos.y;// + 0.33;
    vec3 cloudPosHigh = vec3(localViewDir.xz * ((cloudOffset + CloudHeight) / localViewDir.y), cloudOffset + CloudHeight).xzy;
    vec3 cloudPosLow = vec3(localViewDir.xz * ((cloudOffset) / localViewDir.y), cloudOffset).xzy;

    cloudNear = vec3(0.0);
    cloudFar = vec3(0.0);

    if (cloudPosLow.y > 0.0) {
        // under clouds
        if (localViewDir.y > 0.0) {
            cloudNear = cloudPosLow;
            cloudFar = cloudPosHigh;
        }
    }
    else if (cloudPosHigh.y < 0.0) {
        // above clouds
        if (localViewDir.y < 0.0) {
            cloudNear = cloudPosHigh;
            cloudFar = cloudPosLow;
        }
    }
    else {
        // in clouds
        if (localViewDir.y > 0.0) cloudFar = cloudPosHigh;
        else if (localViewDir.y < 0.0) cloudFar = cloudPosLow;
        else {
            cloudFar = localViewDir * CloudFar;
        }
    }
}

vec4 TraceCloudVL(const in vec3 worldPos, const in vec3 localViewDir, const in float viewDist, const in float depthOpaque) {
    vec3 cloudNear, cloudFar;
    GetCloudNearFar(worldPos, localViewDir, cloudNear, cloudFar);
    
    float cloudDistNear = length(cloudNear);
    float cloudDistFar = length(cloudFar);
    float cloudDist = 0.0;

    if (cloudDistNear < viewDist || depthOpaque >= 0.9999)
        cloudDist = min(cloudDistFar, min(viewDist, CloudFar)) - cloudDistNear;

    float cloudAbsorb = 1.0;
    vec3 cloudScatter = vec3(0.0);

    if (cloudDist > EPSILON) {
        float dither = InterleavedGradientNoise(gl_FragCoord.xy);
        float stepLength = cloudDist / (CLOUD_STEPS + 1);
        vec3 traceStep = localViewDir * stepLength;

        vec3 sampleOffset = worldPos + vec3(worldTime / 40.0, -cloudHeight, worldTime / 8.0);

        float extinctionInv = rcp(CloudAbsorbF);
        float VoL = dot(localSkyLightDirection, localViewDir);
        float phase = DHG(VoL, -0.19, 0.824, 0.09);

        float shadowStepLen = 8.0;
        vec3 shadowStep = localSkyLightDirection * shadowStepLen;

        for (uint stepI = 0; stepI < CLOUD_STEPS; stepI++) {
            vec3 tracePos = cloudNear + traceStep * (stepI + dither);

            float sampleD = SampleCloudOctaves(tracePos + sampleOffset);

            float sampleLit = 1.0;
            for (int shadowI = 0; shadowI < CLOUD_SHADOW_STEPS; shadowI++) {
                vec3 shadowTracePos = tracePos + shadowStep * (shadowI + dither);

                float shadowSampleD = SampleCloudOctaves(shadowTracePos + sampleOffset);

                float shadowY = shadowTracePos.y + sampleOffset.y;
                shadowSampleD *= step(0.0, shadowY) * step(shadowY, CloudHeight);

                sampleLit *= exp(shadowSampleD * CloudAbsorbF * -shadowStepLen);
            }

            // sampleD = smoothstep(mix(0.4, 0.1, rainStrength), 1.0, sampleD);

            float fogDist = GetVanillaFogDistance(tracePos);
            //sampleD *= 1.0 - GetFogFactor(fogDist, 0.65 * CloudFar, CloudFar, 1.0);
            // float fogStart = WorldFogSkyStartF * far * (1.0 - rainStrength);
            // float density = mix(WorldFogSkyDensityF, 0.5, rainStrength);
            // sampleD *= 1.0 - GetFogFactor(fogDist, fogStart, CloudFar, density);
            sampleD *= 1.0 - GetCustomSkyFogFactor(fogDist);

            // float stepAbsorb = exp(stepLength * sampleD * -CloudAbsorbF);

            // cloudScatter = cloudScatter * stepAbsorb + CloudScatterF * stepLength * sampleD * sampleLit;
            // cloudAbsorb *= stepAbsorb;


            vec3 inScattering = (CloudScatterF * sampleD) * stepLength * sampleLit * WorldSkyLightColor * phase;
            float sampleTransmittance = exp(-CloudAbsorbF * stepLength * sampleD);

            vec3 scatteringIntegral = inScattering - inScattering * sampleTransmittance;
            scatteringIntegral *= extinctionInv;

            cloudScatter += scatteringIntegral * cloudAbsorb;
            cloudAbsorb *= sampleTransmittance;
        }
    }

    return vec4(cloudScatter, cloudAbsorb);
}

float TraceCloudShadow(const in vec3 worldPos, const in vec3 localLightDir) {
    vec3 cloudNear, cloudFar;
    GetCloudNearFar(worldPos, localLightDir, cloudNear, cloudFar);
    
    float cloudDistNear = length(cloudNear);
    float cloudDistFar = length(cloudFar);
    float cloudDist = cloudDistFar - cloudDistNear;
    float cloudAbsorb = 1.0;

    if (cloudDist > EPSILON) {
        float dither = InterleavedGradientNoise(gl_FragCoord.xy);
        float cloudStepLen = cloudDist / (CLOUD_STEPS + 1);
        vec3 cloudStep = localLightDir * cloudStepLen;

        vec3 sampleOffset = worldPos + vec3(worldTime / 40.0, -cloudHeight, worldTime / 8.0);

        for (uint stepI = CLOUD_STEPS-1; stepI >= 0; stepI--) {
            vec3 tracePos = cloudNear + cloudStep * (stepI + dither);

            float sampleD = SampleCloudOctaves(tracePos + sampleOffset);

            float shadowY = tracePos.y + sampleOffset.y;
            sampleD *= step(0.0, shadowY) * step(shadowY, CloudHeight);

            //sampleD = smoothstep(mix(0.4, 0.1, rainStrength), 1.0, sampleD);

            float fogDist = GetVanillaFogDistance(tracePos);
            sampleD *= 1.0 - GetFogFactor(fogDist, 0.65 * CloudFar, CloudFar, 1.0);

            float stepAbsorb = exp(cloudStepLen * sampleD * -CloudAbsorbF);

            cloudAbsorb *= stepAbsorb;
        }
    }

    return 1.0 - (1.0 - cloudAbsorb) * (1.0 - ShadowCloudBrightnessF);
}
