#define LIGHT_MASK_UP 1u
#define LIGHT_MASK_DOWN 2u
#define LIGHT_MASK_NORTH 3u
#define LIGHT_MASK_SOUTH 4u
#define LIGHT_MASK_WEST 5u
#define LIGHT_MASK_EAST 6u


#if DYN_LIGHT_MODE != DYN_LIGHT_NONE
    #if defined RENDER_SHADOWCOMP || defined RENDER_SHADOW
        layout(std430, binding = 3) restrict buffer globalLightingData
    #elif defined RENDER_BEGIN
        layout(std430, binding = 3) restrict writeonly buffer globalLightingData
    #else
        layout(std430, binding = 3) restrict readonly buffer globalLightingData
    #endif
    {
        uint SceneLightCount;
        uint SceneLightMaxCount;

        vec3 HandLightPos1;
        vec3 HandLightPos2;

        vec3 sceneViewUp;
        vec3 sceneViewRight;
        vec3 sceneViewDown;
        vec3 sceneViewLeft;

        uvec4 SceneLights[];
    };

    struct LightCellData {
        uint LightCount;
        uint LightNeighborCount;
        uint GlobalLights[LIGHT_BIN_MAX_COUNT];
    };

    #if defined RENDER_SHADOWCOMP || defined RENDER_SHADOW
        layout(std430, binding = 4) restrict buffer localLightingData
    #elif defined RENDER_BEGIN
        layout(std430, binding = 4) restrict writeonly buffer localLightingData
    #else
        layout(std430, binding = 4) restrict readonly buffer localLightingData
    #endif
    {
        LightCellData SceneLightMaps[];
    };

    #if defined RENDER_BEGIN || defined RENDER_SHADOW || defined RENDER_SHADOWCOMP
        layout(r32ui) uniform restrict uimage2D imgLocalLightMask;
    #else
        layout(r32ui) uniform restrict readonly uimage2D imgLocalLightMask;
    #endif
#endif

#if DYN_LIGHT_MODE == DYN_LIGHT_TRACED
    #if defined RENDER_BEGIN || defined RENDER_SHADOW || defined RENDER_SHADOWCOMP
        layout(r16ui) uniform restrict uimage2D imgLocalBlockMask;
    #else
        layout(r16ui) uniform restrict readonly uimage2D imgLocalBlockMask;
    #endif
#endif

struct StaticLightData {
    uint Color;
    uint Offset;
    uint RangeSize;
};

#ifdef RENDER_SETUP
    layout(std430, binding = 2) restrict writeonly buffer staticLightData
#else
    layout(std430, binding = 2) restrict readonly buffer staticLightData
#endif
{
    StaticLightData StaticLightMap[];
};
