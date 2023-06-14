#ifdef RENDER_VERTEX
    void BasicVertex() {
        vec4 pos = gl_Vertex;

        #if defined RENDER_TERRAIN || defined RENDER_WATER || defined RENDER_BLOCK
            vBlockId = int(mc_Entity.x + 0.5);
        #endif

        #if defined RENDER_TERRAIN || defined RENDER_WATER
            #if defined WORLD_SKY_ENABLED && defined WORLD_WAVING_ENABLED
                ApplyWavingOffset(pos.xyz, vBlockId);
            #endif
        #endif

        vec4 viewPos = gl_ModelViewMatrix * pos;

        vPos = viewPos.xyz;

        #ifdef RENDER_BILLBOARD
            vec3 vNormal;
            vec3 vLocalNormal;
        #endif

        vNormal = normalize(gl_NormalMatrix * gl_Normal);
        vLocalNormal = mat3(gbufferModelViewInverse) * vNormal;

        #if defined WORLD_SKY_ENABLED && defined WORLD_SHADOW_ENABLED && SHADOW_TYPE != SHADOW_TYPE_NONE && !defined RENDER_BILLBOARD
            vec3 skyLightDir = normalize(shadowLightPosition);
            geoNoL = dot(skyLightDir, vNormal);
        #else
            geoNoL = 1.0;
        #endif

        vLocalPos = (gbufferModelViewInverse * viewPos).xyz;
        vBlockLight = vec3(0.0);

        #if defined WORLD_SHADOW_ENABLED && SHADOW_TYPE != SHADOW_TYPE_NONE
            #if SHADOW_TYPE == SHADOW_TYPE_CASCADED
                shadowTile = -1;
            #endif

            ApplyShadows(vLocalPos, vLocalNormal, geoNoL);

            #ifdef RENDER_CLOUD_SHADOWS_ENABLED
                ApplyCloudShadows(vLocalPos);
            #endif
        #endif

        #if DYN_LIGHT_MODE != DYN_LIGHT_TRACED && !defined RENDER_CLOUDS
            vec3 blockLightDefault = textureLod(lightmap, vec2(lmcoord.x, (0.5/16.0)), 0).rgb;
            blockLightDefault = RGBToLinear(blockLightDefault);

            #if defined IRIS_FEATURE_SSBO && DYN_LIGHT_MODE != DYN_LIGHT_NONE
                #ifdef RENDER_ENTITIES
                    vec4 lightColor = GetSceneEntityLightColor(entityId);
                    vBlockLight += vec3(lightColor.a / 15.0);
                #elif defined RENDER_HAND
                    // TODO: change ID depending on hand
                    float lightRange = heldBlockLightValue;//GetSceneItemLightRange(heldItemId);
                    vBlockLight += vec3(lightRange / 15.0);
                #elif defined RENDER_TERRAIN || defined RENDER_WATER
                    float lightRange = GetSceneBlockEmission(vBlockId);
                    vBlockLight += vec3(lightRange);
                #endif
            #else
                vBlockLight += blockLightDefault;
            #endif
        #endif

        gl_Position = gl_ProjectionMatrix * viewPos;
    }
#endif

#ifdef RENDER_FRAG
    //#if defined RENDER_GBUFFER || defined RENDER_DEFERRED_RT_LIGHT || defined RENDER_COMPOSITE_RT_LIGHT
        void GetFinalBlockLighting(inout vec3 blockDiffuse, inout vec3 blockSpecular, const in vec3 localPos, const in vec3 localNormal, const in vec3 texNormal, const in float lmcoordX, const in float roughL, const in float metal_f0, const in float sss) {
            #ifdef RENDER_GBUFFER
                vec3 blockLightDefault = textureLod(lightmap, vec2(lmcoordX, 0.5/16.0), 0).rgb;
            #else
                vec3 blockLightDefault = textureLod(TEX_LIGHTMAP, vec2(lmcoordX, 0.5/16.0), 0).rgb;
            #endif

            blockLightDefault = RGBToLinear(blockLightDefault);

            #if defined IRIS_FEATURE_SSBO && DYN_LIGHT_MODE == DYN_LIGHT_TRACED && !defined RENDER_CLOUDS && !(defined RENDER_WEATHER && !defined DYN_LIGHT_WEATHER)
                SampleDynamicLighting(blockDiffuse, blockSpecular, localPos, localNormal, texNormal, roughL, metal_f0, sss, blockLightDefault);
            #endif

            #if LPV_SIZE > 0 && DYN_LIGHT_MODE == DYN_LIGHT_PIXEL
                vec3 lpvPos = GetLPVPosition(localPos + 0.52 * localNormal);
                vec3 lpvTexcoord = GetLPVTexCoord(lpvPos);

                float lpvFade = GetLpvFade(lpvPos);
                lpvFade = smoothstep(0.0, 1.0, lpvFade);

                if (saturate(lpvTexcoord) == lpvTexcoord) {
                    vec3 lpvLight = (frameCounter % 2) == 0
                        ? textureLod(texLPV_1, lpvTexcoord, 0).rgb
                        : textureLod(texLPV_2, lpvTexcoord, 0).rgb;

                    lpvLight /= 16.0 * LpvRangeF;
                    lpvLight /= 1.0 + luminance(lpvLight);
                    //lpvLight /= LpvRangeF;
                    blockDiffuse += mix(blockLightDefault, lpvLight, lpvFade);
                }
                else blockDiffuse += blockLightDefault;
            #endif

            #if DYN_LIGHT_MODE == DYN_LIGHT_NONE
                blockDiffuse += blockLightDefault;
            #endif

            //SampleHandLight(blockDiffuse, blockSpecular, localPos, localNormal, texNormal, roughL, metal_f0, sss);

            #if defined IRIS_FEATURE_SSBO && DYN_LIGHT_MODE != DYN_LIGHT_NONE && !(defined WORLD_SHADOW_ENABLED && SHADOW_TYPE != SHADOW_TYPE_NONE) && !(defined RENDER_CLOUDS || defined RENDER_DEFERRED || defined RENDER_COMPOSITE)
                if (gl_FragCoord.x < 0) blockDiffuse = texelFetch(shadowcolor0, ivec2(0.0), 0).rgb;
            #endif
        }
    //#endif

    #if defined WORLD_SKY_ENABLED && !(defined RENDER_OPAQUE_RT_LIGHT || defined RENDER_TRANSLUCENT_RT_LIGHT)
        float GetReflectiveness(const in float NoVm, const in float f0, const in float roughL) {
            return F_schlickRough(NoVm, f0, roughL) * (1.0 - sqrt(roughL)) * WorldSkyReflectF;
        }

        void ApplyFresnel(inout vec3 diffuse, inout vec3 specular, const in vec3 localViewDir, const in vec3 texNormal, const in float skyReflectF, const in float skyLight) {
            //float skyLight = saturate((lmcoordY - (0.5/16.0)) / (15.0/16.0));

            vec3 reflectDir = reflect(-localViewDir, texNormal);

            #if WORLD_FOG_MODE == FOG_MODE_CUSTOM
                vec3 reflectColor;
                if (isEyeInWater == 1) {
                    #ifndef IRIS_FEATURE_SSBO
                        vec3 WorldSkyLightColor = GetSkyLightColor();
                    #endif

                    vec3 skyLightColor = CalculateSkyLightWeatherColor(WorldSkyLightColor);

                    //vec3 skyColorFinal = RGBToLinear(skyColor);
                    reflectColor = GetCustomWaterFogColor(localSunDirection.y);
                }
                else {
                    vec3 skyColorFinal = RGBToLinear(skyColor);
                    reflectColor = GetCustomSkyFogColor(localSunDirection.y);
                    reflectColor = GetSkyFogColor(skyColorFinal, reflectColor, localViewDir.y);
                }
            #else
                vec3 reflectColor = GetVanillaFogColor(fogColor, reflectDir.y);
                reflectColor = RGBToLinear(reflectColor);
            #endif

            float m = skyLight * 0.3;
            reflectColor *= smoothstep(-0.6, 1.0, reflectDir.y) * (1.0 - m) + m;

            //float skyReflectF = GetReflectiveness(skyNoVm, f0, roughL);
            specular += reflectColor * skyReflectF * pow5(skyLight);
            diffuse *= 1.0 - skyReflectF;
        }
        
        void GetSkyLightingFinal(inout vec3 skyDiffuse, inout vec3 skySpecular, const in vec3 shadowPos, const in vec3 shadowColor, const in vec3 localPos, const in vec3 localNormal, const in vec3 texNormal, const in vec2 lmcoord, const in float roughL, const in float metal_f0, const in float occlusion, const in float sss) {
            vec3 localViewDir = -normalize(localPos);

            #ifndef RENDER_CLOUDS
                #ifdef RENDER_GBUFFER
                    vec3 skyLightColor = textureLod(lightmap, vec2((0.5/15.0), lmcoord.y), 0).rgb;
                #else
                    vec3 skyLightColor = textureLod(TEX_LIGHTMAP, vec2((0.5/15.0), lmcoord.y), 0).rgb;
                #endif

                skyLightColor = RGBToLinear(skyLightColor);

                //skyLightColor = skyLightColor * (1.0 - ShadowBrightnessF) + (ShadowBrightnessF);

                //skyLightColor *= 1.0 - blindness;
            #else
                vec3 skyLightColor = vec3(1.0);
            #endif

            #ifndef LIGHT_LEAK_FIX
                float shadow = maxOf(abs(shadowPos * 2.0 - 1.0));
                shadow = 1.0 - smoothstep(0.5, 0.8, shadow);

                skyLightColor = mix(skyLightColor, vec3(1.0), shadow);
            #endif

            #ifndef IRIS_FEATURE_SSBO
                vec3 WorldSkyLightColor = GetSkyLightColor();
            #endif

            skyLightColor *= CalculateSkyLightWeatherColor(WorldSkyLightColor);// * WorldSkyBrightnessF;
            //skyLightColor *= 1.0 - 0.7 * rainStrength;
            
            #ifndef IRIS_FEATURE_SSBO
                #if defined WORLD_SHADOW_ENABLED && SHADOW_TYPE != SHADOW_TYPE_NONE
                    vec3 localSkyLightDirection = normalize((gbufferModelViewInverse * vec4(shadowLightPosition, 1.0)).xyz);
                #else
                    vec3 localSkyLightDirection = normalize((gbufferModelViewInverse * vec4(sunPosition, 1.0)).xyz);
                    if (worldTime > 12000 && worldTime < 24000)
                        localSkyLightDirection = -localSkyLightDirection;
                #endif
            #endif

            float geoNoL = 1.0;
            if (!all(lessThan(abs(localNormal), EPSILON3)))
                geoNoL = dot(localNormal, localSkyLightDirection);

            #if (defined IRIS_FEATURE_SSBO && DYN_LIGHT_MODE != DYN_LIGHT_NONE) || (defined WORLD_SHADOW_ENABLED && SHADOW_TYPE != SHADOW_TYPE_NONE)
                float diffuseNoL = GetLightNoL(geoNoL, texNormal, localSkyLightDirection, sss);
            #else
                const float diffuseNoL = 1.0;
            #endif

            // TODO: replace this crap with actual diffuse function
            vec3 H = normalize(-localSkyLightDirection + -localViewDir);
            float diffuseNoVm = max(dot(texNormal, localViewDir), 0.0);
            float diffuseLoHm = max(dot(localSkyLightDirection, H), 0.0);
            float D = SampleLightDiffuse(diffuseNoVm, diffuseNoL, diffuseLoHm, roughL);
            vec3 accumDiffuse = skyLightColor * D * mix(shadowColor, vec3(1.0), ShadowBrightnessF);// * roughL;



            vec2 lmFinal = lmcoord;

            lmFinal.x = (lmFinal.x - (0.5/15.0));

            #if LPV_SIZE > 0
                vec3 surfacePos = localPos;
                surfacePos += 0.501 * localNormal;// * (1.0 - sss);

                vec3 lpvPos = GetLPVPosition(surfacePos);

                //vec3 lpvTexcoord = GetLPVTexCoord(lpvPos);

                float lpvFade = GetLpvFade(lpvPos);
                lpvFade = smoothstep(0.0, 1.0, lpvFade);

                lmFinal.x *= 1.0 - lpvFade;

                vec3 voxelPos = GetVoxelBlockPosition(surfacePos);
            #endif

            lmFinal.x += (0.5/15.0);

            #ifdef RENDER_GBUFFER
                vec3 lightmapColor = textureLod(lightmap, lmFinal, 0).rgb;
            #else
                vec3 lightmapColor = textureLod(TEX_LIGHTMAP, lmFinal, 0).rgb;
            #endif

            vec3 ambientLight = RGBToLinear(lightmapColor);

            #if LPV_SIZE > 0
                //if (saturate(lpvTexcoord) == lpvTexcoord) {
                    vec3 lpvLight = SampleLpvVoxel(voxelPos, lpvPos);

                    lpvLight /= 16.0 * LpvRangeF;
                    lpvLight /= 4.0 + luminance(lpvLight);
                    //lpvLight /= 8.0 + luminance(lpvLight);
                    //lpvLight /= LpvRangeF;

                    #if LPV_LIGHTMAP_MIX > 0
                        ambientLight *= 1.0 - (1.0 - LpvLightmapMixF)*lpvFade;
                    #endif
                    
                    ambientLight += lpvLight * lpvFade;
                //}
            #endif

            ambientLight += WorldMinLightF;
            ambientLight *= DynamicLightAmbientF;

            // #if defined WORLD_SKY_ENABLED && WORLD_SKY_REFLECTIONS > 0
            //     //float skyLight = saturate((lmcoord.y - (0.5/16.0)) / (15.0/16.0));
            //     float skyNoVm = max(dot(texNormal, localViewDir), 0.0);
            //     float f0 = GetMaterialF0(metal_f0);

            //     float skyReflectF = GetReflectiveness(skyNoVm, f0, roughL);
            //     //ApplyFresnel(ambientLight, skySpecular, localViewDir, texNormal, skyReflectF, skyLight);
            //     ambientLight *= 1.0 - skyReflectF;
            // #endif

            accumDiffuse += ambientLight * occlusion;// * roughL;

            #if MATERIAL_SPECULAR != SPECULAR_NONE
                if (metal_f0 >= 0.5) {
                    accumDiffuse *= mix(MaterialMetalBrightnessF, 1.0, roughL);
                }
            #endif



            #if MATERIAL_SPECULAR != SPECULAR_NONE && !defined RENDER_CLOUDS
                // float geoNoL = 1.0;
                // if (any(greaterThan(localNormal, EPSILON3)))
                //     geoNoL = max(dot(localNormal, localSkyLightDirection), 0.0);

                //if (geoNoL > EPSILON) {
                    float f0 = GetMaterialF0(metal_f0);

                    vec3 localSkyLightDir = localSkyLightDirection;
                    //#if DYN_LIGHT_TYPE == LIGHT_TYPE_AREA
                        const float skyLightSize = 480.0;

                        vec3 r = reflect(-localViewDir, texNormal);
                        vec3 L = localSkyLightDir * 10000.0;
                        vec3 centerToRay = dot(L, r) * r - L;
                        vec3 closestPoint = L + centerToRay * saturate(skyLightSize / length(centerToRay));
                        localSkyLightDir = normalize(closestPoint);
                    //#endif

                    vec3 skyH = normalize(localSkyLightDir + localViewDir);
                    float skyVoHm = max(dot(localViewDir, skyH), 0.0);

                    float skyNoLm = 1.0, skyNoVm = 1.0, skyNoHm = 1.0;
                    if (!all(lessThan(abs(texNormal), EPSILON3))) {
                        skyNoLm = max(dot(texNormal, localSkyLightDir), 0.0);
                        skyNoVm = max(dot(texNormal, localViewDir), 0.0);
                        skyNoHm = max(dot(texNormal, skyH), 0.0);
                    }

                    //float invCosTheta = 1.0 - skyVoHm;
                    //float skyF = f0 + (max(1.0 - roughL, f0) - f0) * pow5(invCosTheta);
                    float skyF = F_schlick(skyVoHm, f0, 1.0);

                    skyLightColor *= 1.0 - 0.92*rainStrength;

                    //#if DYN_LIGHT_TYPE == LIGHT_TYPE_AREA
                    //    skyLightColor *= invPI;
                    //#endif

                    float invGeoNoL = saturate(geoNoL*40.0);
                    skySpecular += invGeoNoL * SampleLightSpecular(skyNoVm, skyNoLm, skyNoHm, skyF, roughL) * skyLightColor * shadowColor;
                //}

                #if defined WORLD_SKY_ENABLED && WORLD_SKY_REFLECTIONS > 0
                    float skyLight = saturate((lmcoord.y - (0.5/16.0)) / (15.0/16.0));

                    float skyReflectF = GetReflectiveness(skyNoVm, f0, roughL);
                    ApplyFresnel(accumDiffuse, skySpecular, localViewDir, texNormal, skyReflectF, skyLight);
                #endif
            #endif

            skyDiffuse += accumDiffuse;
        }
    #endif

    #if !(defined RENDER_OPAQUE_RT_LIGHT || defined RENDER_TRANSLUCENT_RT_LIGHT)
        vec3 GetFinalLighting(const in vec3 albedo, const in vec3 localPos, const in vec3 geoNormal, const in vec3 diffuse, const in vec3 specular, const in vec2 lmcoord, const in float metal_f0, const in float roughL, const in float occlusion, const in float sss) {
            // #if defined IRIS_FEATURE_SSBO && (DYN_LIGHT_MODE != DYN_LIGHT_NONE || LPV_SIZE > 0)
            //     vec2 lmFinal = lmcoord;

            //     lmFinal.x = (lmFinal.x - (0.5/15.0));

            //     #if LPV_SIZE > 0
            //         vec3 surfacePos = localPos;
            //         surfacePos += 0.501 * geoNormal;// * (1.0 - sss);

            //         vec3 lpvPos = GetLPVPosition(surfacePos);

            //         //vec3 lpvTexcoord = GetLPVTexCoord(lpvPos);

            //         float lpvFade = GetLpvFade(lpvPos);
            //         lpvFade = smoothstep(0.0, 1.0, lpvFade);

            //         lmFinal.x *= 1.0 - lpvFade;

            //         vec3 voxelPos = GetVoxelBlockPosition(surfacePos);
            //     #endif

            //     lmFinal.x += (0.5/15.0);

            //     #ifdef RENDER_GBUFFER
            //         vec3 lightmapColor = textureLod(lightmap, lmFinal, 0).rgb;
            //     #else
            //         vec3 lightmapColor = textureLod(TEX_LIGHTMAP, lmFinal, 0).rgb;
            //     #endif

            //     vec3 ambientLight = RGBToLinear(lightmapColor);

            //     #if LPV_SIZE > 0
            //         //if (saturate(lpvTexcoord) == lpvTexcoord) {
            //             vec3 lpvLight = SampleLpvVoxel(voxelPos, lpvPos);

            //             lpvLight /= 16.0 * LpvRangeF;
            //             lpvLight /= 4.0 + luminance(lpvLight);
            //             //lpvLight /= 8.0 + luminance(lpvLight);
            //             //lpvLight /= LpvRangeF;

            //             #if LPV_LIGHTMAP_MIX > 0
            //                 ambientLight *= 1.0 - (1.0 - LpvLightmapMixF)*lpvFade;
            //             #endif
                        
            //             ambientLight += lpvLight * lpvFade;
            //         //}
            //     #endif

            //     ambientLight += WorldMinLightF;
            //     ambientLight *= DynamicLightAmbientF;

            //     #if MATERIAL_SPECULAR != SPECULAR_NONE
            //         if (metal_f0 >= 0.5) {
            //             ambientLight *= mix(MaterialMetalBrightnessF, 1.0, roughL);
            //         }
            //     #endif

            //     #if defined WORLD_SKY_ENABLED && WORLD_SKY_REFLECTIONS > 0
            //         //float skyLight = saturate((lmcoord.y - (0.5/16.0)) / (15.0/16.0));
            //         float skyNoVm = max(dot(texNormal, localViewDir), 0.0);
            //         float f0 = GetMaterialF0(metal_f0);

            //         float skyReflectF = GetReflectiveness(skyNoVm, f0, roughL);
            //         //ApplyFresnel(ambientLight, skySpecular, localViewDir, texNormal, skyReflectF, skyLight);
            //         ambientLight *= 1.0 - skyReflectF;
            //     #endif

            //     vec3 diffuseFinal = albedo * (diffuse + ambientLight * occlusion);
            // #else
            //    vec3 diffuseFinal = albedo * diffuse;// * occlusion;
            // #endif

            // TODO: handle specular occlusion
            return albedo * diffuse + specular * occlusion;
        }
    #endif
#endif
