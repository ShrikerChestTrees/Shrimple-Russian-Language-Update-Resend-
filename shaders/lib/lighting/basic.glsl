#ifdef RENDER_VERTEX
    void BasicVertex() {
        vec4 pos = gl_Vertex;

        #if defined RENDER_TERRAIN || defined RENDER_WATER
            vBlockId = int(mc_Entity.x + 0.5);

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
            vec3 lightDir = normalize(shadowLightPosition);
            geoNoL = dot(lightDir, vNormal);
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
        #endif

        #if DYN_LIGHT_MODE != DYN_LIGHT_TRACED && !defined RENDER_CLOUDS
            vec3 blockLightDefault = textureLod(lightmap, vec2(lmcoord.x, (0.5/16.0)), 0).rgb;
            blockLightDefault = RGBToLinear(blockLightDefault);

            #if defined IRIS_FEATURE_SSBO && DYN_LIGHT_MODE == DYN_LIGHT_VERTEX && !defined RENDER_BILLBOARD
                #if defined RENDER_TERRAIN || defined RENDER_WATER
                    float sss = GetBlockSSS(vBlockId);
                #else
                    const float sss = 0.0;
                #endif

                const float roughL = 0.2;
                const float metal_f0 = 0.04;

                vec3 blockDiffuse = vec3(0.0);
                vec3 blockSpecular = vec3(0.0);
                SampleDynamicLighting(blockDiffuse, blockSpecular, vLocalPos, vLocalNormal, vec3(0.0), roughL, metal_f0, sss, blockLightDefault);
                SampleHandLight(blockDiffuse, blockSpecular, vLocalPos, vLocalNormal, vec3(0.0), roughL, metal_f0, sss);

                vBlockLight += blockDiffuse * saturate((lmcoord.x - (0.5/16.0)) * (16.0/15.0));
            #endif

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
    #if defined RENDER_GBUFFER && !defined RENDER_CLOUDS
        vec4 GetColor() {
            vec4 color = texture(gtexture, texcoord);

            #ifndef RENDER_TRANSLUCENT
                if (color.a < alphaTestRef) {
                    discard;
                    return vec4(0.0);
                }
            #endif

            color.rgb *= glcolor.rgb;

            return color;
        }
    #endif

    void GetFinalBlockLighting(inout vec3 blockDiffuse, inout vec3 blockSpecular, const in vec3 localPos, const in vec3 localNormal, const in vec3 texNormal, const in float lmcoordX, const in float roughL, const in float metal_f0, const in float sss) {
        #ifdef RENDER_GBUFFER
            vec3 blockLightDefault = textureLod(lightmap, vec2(lmcoordX, 0.5/16.0), 0).rgb;
        #else
            vec3 blockLightDefault = textureLod(TEX_LIGHTMAP, vec2(lmcoordX, 0.5/16.0), 0).rgb;
        #endif

        blockLightDefault = RGBToLinear(blockLightDefault);

        #if defined RENDER_WEATHER && !defined DYN_LIGHT_WEATHER
            blockDiffuse += blockLightDefault;
        #elif defined IRIS_FEATURE_SSBO && (DYN_LIGHT_MODE == DYN_LIGHT_PIXEL || DYN_LIGHT_MODE == DYN_LIGHT_TRACED || (DYN_LIGHT_MODE == DYN_LIGHT_VERTEX && (defined RENDER_WEATHER || defined RENDER_DEFERRED))) && !(defined RENDER_CLOUDS || defined RENDER_COMPOSITE)
            SampleDynamicLighting(blockDiffuse, blockSpecular, localPos, localNormal, texNormal, roughL, metal_f0, sss, blockLightDefault);
        #else
            blockDiffuse += blockLightDefault;
        #endif

        SampleHandLight(blockDiffuse, blockSpecular, localPos, localNormal, texNormal, roughL, metal_f0, sss);

        #if defined IRIS_FEATURE_SSBO && DYN_LIGHT_MODE != DYN_LIGHT_NONE && !(defined WORLD_SHADOW_ENABLED && SHADOW_TYPE != SHADOW_TYPE_NONE) && !(defined RENDER_CLOUDS || defined RENDER_DEFERRED)
            if (gl_FragCoord.x < 0) blockDiffuse = texelFetch(shadowcolor0, ivec2(0.0), 0).rgb;
        #endif
    }

    #ifdef WORLD_SKY_ENABLED
        void GetSkyLightingFinal(inout vec3 skyDiffuse, inout vec3 skySpecular, const in vec3 shadowColor, const in vec3 localViewDir, const in vec3 localNormal, const in vec3 texNormal, const in float lmcoordY, const in float roughL, const in float metal_f0, const in float sss) {
            #ifndef RENDER_CLOUDS
                #ifdef RENDER_GBUFFER
                    vec3 skyLight = textureLod(lightmap, vec2(0.5/16.0, lmcoordY), 0).rgb;
                #else
                    vec3 skyLight = textureLod(TEX_LIGHTMAP, vec2(0.5/16.0, lmcoordY), 0).rgb;
                #endif

                skyLight = RGBToLinear(skyLight) * WorldSkyBrightnessF;

                //skyLight = skyLight * (1.0 - ShadowBrightnessF) + (ShadowBrightnessF);

                skyLight *= 1.0 - blindness;
            #else
                float skyLight = 1.0;
            #endif

            //skyLight *= 1.0 - 0.8*rainStrength;
            
            #ifndef IRIS_FEATURE_SSBO
                #if defined WORLD_SHADOW_ENABLED && SHADOW_TYPE != SHADOW_TYPE_NONE
                    vec3 localSkyLightDirection = normalize((gbufferModelViewInverse * vec4(shadowLightPosition, 1.0)).xyz);
                #else
                    vec3 localSkyLightDirection = localSunDirection;
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

            skyDiffuse += skyLight * mix(diffuseNoL * shadowColor, vec3(1.0), ShadowBrightnessF);

            #if MATERIAL_SPECULAR != SPECULAR_NONE
                // float geoNoL = 1.0;
                // if (any(greaterThan(localNormal, EPSILON3)))
                //     geoNoL = max(dot(localNormal, localSkyLightDirection), 0.0);

                //if (geoNoL > EPSILON) {
                    float f0 = GetMaterialF0(metal_f0);

                    //vec3 localViewDir = normalize(localPos);

                    vec3 skyH = normalize(localSkyLightDirection + localViewDir);
                    float skyVoHm = max(dot(localViewDir, skyH), 0.0);

                    float skyNoLm = 1.0, skyNoVm = 1.0, skyNoHm = 1.0;
                    if (!all(lessThan(abs(texNormal), EPSILON3))) {
                        skyNoLm = max(dot(texNormal, localSkyLightDirection), 0.0);
                        skyNoVm = max(dot(texNormal, localViewDir), 0.0);
                        skyNoHm = max(dot(texNormal, skyH), 0.0);
                    }

                    float invCosTheta = 1.0 - skyVoHm;
                    float skyF = f0 + (max(1.0 - roughL, f0) - f0) * pow5(invCosTheta);

                    skyLight *= 1.0 - 0.92*rainStrength;

                    float invGeoNoL = saturate(geoNoL*40.0 + 1.0);
                    skySpecular += invGeoNoL * SampleLightSpecular(skyNoVm, skyNoLm, skyNoHm, skyF, roughL) * skyLight * shadowColor;
                //}
            #endif
        }
    #endif

    vec3 GetFinalLighting(const in vec3 albedo, const in vec3 localNormal, const in vec3 blockDiffuse, const in vec3 blockSpecular, const in vec3 skyDiffuse, const in vec3 skySpecular, const in vec2 lmcoord, const in float metal_f0, const in float occlusion) {
        #if defined IRIS_FEATURE_SSBO && DYN_LIGHT_MODE != DYN_LIGHT_NONE
            vec2 lmFinal = lmcoord;
            //lmFinal.x = (0.5/16.0);
            lmFinal.x = (lmFinal.x - (0.5/16.0)) * 0.5 + (0.5/16.0);

            #ifdef RENDER_GBUFFER
                vec3 lightmapColor = textureLod(lightmap, lmFinal, 0).rgb;
            #else
                vec3 lightmapColor = textureLod(TEX_LIGHTMAP, lmFinal, 0).rgb;
            #endif

            vec3 ambientLight = RGBToLinear(lightmapColor);

            // #if WORLD_AMBIENT_MODE == AMBIENT_FANCY
            //     #ifdef WORLD_SKY_ENABLED
            //         #ifndef IRIS_FEATURE_SSBO
            //             vec3 localSunDirection = normalize((gbufferModelViewInverse * vec4(sunPosition, 1.0)).xyz);

            //             #if defined WORLD_SHADOW_ENABLED && SHADOW_TYPE != SHADOW_TYPE_NONE
            //                 vec3 localSkyLightDirection = normalize((gbufferModelViewInverse * vec4(shadowLightPosition, 1.0)).xyz);
            //             #else
            //                 vec3 localSkyLightDirection = localSunDirection;
            //                 if (worldTime > 12000 && worldTime < 24000)
            //                     localSkyLightDirection = -localSkyLightDirection;
            //             #endif
            //         #endif

            //         const vec3 sunLightColor = RGBToLinear(vec3(0.965, 0.901, 0.725));
            //         const vec3 moonLightColor = RGBToLinear(vec3(0.864, 0.860, 0.823));
            //         vec3 skyLightColor = mix(moonLightColor, sunLightColor, localSunDirection.y * 0.5 + 0.5);

            //         float skyLightNoL = max(dot(localNormal, localSkyLightDirection), 0.0);
            //         ambientLight = 0.3 * skyColor + skyLightColor * (skyLightNoL * 0.3 + 0.5);
            //     #endif

            //     //ambientLight *= 0.34 + 0.66 * min(localNormal.y + 1.0, 1.0);
            // #endif

            ambientLight *= WorldBrightnessF * _pow2(occlusion);

            vec3 diffuse = albedo * (blockDiffuse + (skyDiffuse + ambientLight));
        #else
            vec3 diffuse = albedo * (pow(blockDiffuse, vec3(2.0 - WorldBrightnessF)) + pow(skyDiffuse, vec3(2.0 - WorldBrightnessF))) * _pow2(occlusion);
        #endif

        vec3 specular = blockSpecular + skySpecular;

        #if MATERIAL_SPECULAR != SPECULAR_NONE
            if (metal_f0 >= 0.5) {
                diffuse *= METAL_BRIGHTNESS;
                specular *= albedo;
            }
        #endif

        return diffuse + specular * occlusion;
    }
#endif
