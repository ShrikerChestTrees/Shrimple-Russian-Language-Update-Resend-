float fogify(float x, float w) {
    return w / (x * x + w);
}

vec3 GetSkyFogColor(const in vec3 skyColor, const in vec3 fogColor, const in float viewUpF) {
    #ifdef WORLD_SKY_ENABLED
        float fogF = fogify(max(viewUpF, 0.0), 0.06);
        return mix(skyColor, fogColor, fogF);
    #else
        return fogColorFinal;
    #endif
}

vec3 GetVanillaFogColor(const in vec3 fogColor, const in float viewUpF) {
    #if defined WORLD_WATER_ENABLED //&& !(defined RENDER_SKYBASIC || defined RENDER_SKYTEXTURED)
        if (isEyeInWater == 1) return fogColor;
    #endif
    
    return GetSkyFogColor(skyColor, fogColor, viewUpF);
}

// float GetViewUpF(const in vec3 viewDir) {
//     return dot(viewDir, gbufferModelView[1].xyz);
// }

// vec3 GetSkyFogColor(const in vec3 fogColor, const in float viewUpF) {
//     vec3 skyColorL = RGBToLinear(skyColor);
//     vec3 fogColorL = RGBToLinear(fogColor);
//     return GetSkyFogColor(skyColorL, fogColorL, viewUpF);
// }

float GetFogFactor(const in float dist, const in float start, const in float end, const in float density) {
    float distFactor = dist >= end ? 1.0 : smoothstep(start, end, dist);
    return saturate(pow(distFactor, density));
}

#ifdef WORLD_FOG_MODE == FOG_MODE_CUSTOM
    vec3 GetCustomWaterFogColor(const in float sunUpF) {
        const vec3 _color = RGBToLinear(vec3(0.04, 0.16, 0.32));
        const float WaterMinBrightness = 0.04;

        float brightnessF = 1.0 - WaterMinBrightness;
        float eyeBrightness = eyeBrightnessSmooth.y / 240.0;
        float skyBrightness = smoothstep(-0.1, 0.3, sunUpF);
        //skyBrightness = mix(WorldMoonBrightnessF, WorldSunBrightnessF, skyBrightness);
        skyBrightness *= WorldSunBrightnessF;
        return _color * (WaterMinBrightness + brightnessF * skyBrightness * eyeBrightness);
    }

    float GetCustomWaterFogFactor(const in float fogDist) {
        return GetFogFactor(fogDist, 0.0, min(20.0, far), 0.2);
    }

    vec3 GetCustomSkyFogColor(const in float sunUpF) {
        const vec3 colorNight = RGBToLinear(vec3(0.096, 0.081, 0.121));
        const vec3 colorDay = RGBToLinear(vec3(0.975, 0.954, 0.890));

        float f = smoothstep(-0.1, 0.3, sunUpF);
        return mix(colorNight, colorDay, f);
    }

    float GetCustomSkyFogFactor(const in float fogDist) {
        float fogStart = WorldFogSkyStartF * far;
        return GetFogFactor(fogDist, fogStart, far, WorldFogSkyDensityF);
    }
#endif

#if !(defined RENDER_SKYBASIC || defined RENDER_SKYTEXTURED)
    float GetVanillaFogDistance(const in vec3 localPos) {
        //if (fogStart > far) return 0.0;

        vec3 fogPos = localPos;
        if (fogShape == 1)
            fogPos.y = 0.0;

        return length(fogPos);// * rcp(WorldFogScaleF);
    }

    float GetVanillaFogFactor(const in vec3 localPos) {
        float fogDist = GetVanillaFogDistance(localPos);
        return GetFogFactor(fogDist, fogStart, fogEnd, 1.0);
    }
#endif

#if defined RENDER_GBUFFER && !(defined RENDER_SKYBASIC || defined RENDER_SKYTEXTURED || defined RENDER_CLOUDS) // || defined RENDER_DEFERRED || defined RENDER_COMPOSITE)
    #if WORLD_FOG_MODE == FOG_MODE_CUSTOM
        void ApplyWaterFog(inout vec4 color, const in vec3 localPos, const in float waterDepth) {
        }

        void ApplySkyFog(inout vec4 color, const in vec3 localPos, const in float waterDepth) {
        }
    #endif

    void ApplyVanillaFog(inout vec4 color, const in vec3 localPos) {
        vec3 localViewDir = normalize(localPos);

        float fogF = GetVanillaFogFactor(localPos);
        vec3 fogColorFinal = GetVanillaFogColor(fogColor, localViewDir.y);
        fogColorFinal = RGBToLinear(fogColorFinal);

        color.rgb = mix(color.rgb, fogColorFinal, fogF);

        if (color.a > alphaTestRef)
            color.a = mix(color.a, 1.0, fogF);
    }

    void ApplyFog(inout vec4 color, const in vec3 localPos, const in vec3 localViewDir) {
        ApplyVanillaFog(color, localPos);
    }
#endif
