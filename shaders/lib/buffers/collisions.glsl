struct CollissionData {
    uint LightId;                       // 4

    #if DYN_LIGHT_MODE != DYN_LIGHT_NONE
        uint Count;                     // 4
        uvec2 Bounds[BLOCK_MASK_PARTS]; // 48
    #endif
};

#ifdef RENDER_SETUP
    layout(std430, binding = 4) writeonly buffer collissionData
#else
    layout(std430, binding = 4) readonly buffer collissionData
#endif
{
    CollissionData CollissionMaps[];   // 56 * 1200 = 67200
};
