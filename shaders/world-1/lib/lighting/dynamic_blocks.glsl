#if DYN_LIGHT_MODE == DYN_LIGHT_TRACED
    bool IsDynLightSolidBlock(const in int blockId) {
        if (blockId < 1) return true;
        return blockId >= 300 && blockId < 600;
    }
#endif

float GetBlockSSS(const in int blockId) {
    float sss = 0.0;

    switch (blockId) {
        case BLOCK_BROWN_MUSHROOM:
        case BLOCK_LILY_PAD:
        case BLOCK_NETHER_WART:
        case BLOCK_RED_MUSHROOM:
            sss = 0.2;
            break;
        case BLOCK_AZALEA:
        case BLOCK_BIG_DRIPLEAF:
        case BLOCK_BIG_DRIPLEAF_STEM:
        case BLOCK_CAVE_VINE:
        case BLOCK_CAVEVINE_BERRIES:
        case BLOCK_FERN:
        case BLOCK_KELP:
        case BLOCK_LEAVES:
        case BLOCK_LARGE_FERN_LOWER:
        case BLOCK_LARGE_FERN_UPPER:
        case BLOCK_SAPLING:
        case BLOCK_SEAGRASS:
        case BLOCK_SMALL_DRIPLEAF:
        case BLOCK_SWEET_BERRY_BUSH:
        case BLOCK_TWISTING_VINES:
        case BLOCK_VINE:
        case BLOCK_WEEPING_VINES:
        case BLOCK_AMETHYST:
        case BLOCK_DIAMOND:
        case BLOCK_EMERALD:
            sss = 0.4;
            break;
        case BLOCK_ALLIUM:
        case BLOCK_AZURE_BLUET:
        case BLOCK_BEETROOTS:
        case BLOCK_BLUE_ORCHID:
        case BLOCK_CARROTS:
        case BLOCK_CORNFLOWER:
        case BLOCK_DANDELION:
        case BLOCK_LILAC_LOWER:
        case BLOCK_LILAC_UPPER:
        case BLOCK_LILY_OF_THE_VALLEY:
        case BLOCK_OXEYE_DAISY:
        case BLOCK_PEONY_LOWER:
        case BLOCK_PEONY_UPPER:
        case BLOCK_POPPY:
        case BLOCK_POTATOES:
        case BLOCK_ROSE_BUSH_LOWER:
        case BLOCK_ROSE_BUSH_UPPER:
        case BLOCK_SPORE_BLOSSOM:
        case BLOCK_SUNFLOWER_LOWER:
        case BLOCK_SUNFLOWER_UPPER:
        case BLOCK_TULIP:
        case BLOCK_WHEAT:
        case BLOCK_WITHER_ROSE:
            sss = 0.6;
            break;
        case BLOCK_GRASS:
        case BLOCK_TALL_GRASS_UPPER:
        case BLOCK_TALL_GRASS_LOWER:
        case BLOCK_SNOW:
            sss = 0.8;
            break;
    }

    return sss;
}

vec3 GetSceneBlockLightColor(const in uint lightType, const in vec2 noiseSample) {
    vec3 lightColor = vec3(0.0);

    switch (lightType) {
        case BLOCK_AMETHYST_CLUSTER:
        case BLOCK_AMETHYST_BUD_LARGE:
        case BLOCK_AMETHYST_BUD_MEDIUM:
            lightColor = vec3(0.447, 0.188, 0.758);
            break;
        case BLOCK_BEACON:
            lightColor = vec3(1.0, 1.0, 1.0);
            break;
        case BLOCK_BLAST_FURNACE_LIT_N:
        case BLOCK_BLAST_FURNACE_LIT_E:
        case BLOCK_BLAST_FURNACE_LIT_S:
        case BLOCK_BLAST_FURNACE_LIT_W:
            lightColor = vec3(0.697, 0.654, 0.458);
            break;
        case BLOCK_BREWING_STAND:
            lightColor = vec3(0.636, 0.509, 0.179);
            break;
        case BLOCK_CANDLES_LIT_1:
        case BLOCK_CANDLES_LIT_2:
        case BLOCK_CANDLES_LIT_3:
        case BLOCK_CANDLES_LIT_4:
        case BLOCK_CANDLE_CAKE_LIT:
            lightColor = vec3(0.758, 0.553, 0.239);
            break;
        case BLOCK_CAVEVINE_BERRIES:
            lightColor = 0.4 * vec3(0.717, 0.541, 0.188);
            break;
        case BLOCK_CRYING_OBSIDIAN:
            lightColor = vec3(0.390, 0.065, 0.646);
            break;
        case BLOCK_END_ROD:
            lightColor = vec3(0.957, 0.929, 0.875);
            break;
        case BLOCK_CAMPFIRE_LIT:
        case BLOCK_FIRE:
            lightColor = vec3(0.851, 0.616, 0.239);
            break;
        case BLOCK_FURNACE_LIT_N:
        case BLOCK_FURNACE_LIT_E:
        case BLOCK_FURNACE_LIT_S:
        case BLOCK_FURNACE_LIT_W:
            lightColor = vec3(0.697, 0.654, 0.458);
            break;
        case BLOCK_GLOWSTONE:
            lightColor = vec3(0.652, 0.583, 0.275);
            break;
        case BLOCK_GLOW_LICHEN:
            lightColor = vec3(0.173, 0.374, 0.252);
            break;
        case BLOCK_JACK_O_LANTERN_N:
        case BLOCK_JACK_O_LANTERN_E:
        case BLOCK_JACK_O_LANTERN_S:
        case BLOCK_JACK_O_LANTERN_W:
            lightColor = vec3(0.768, 0.701, 0.325);
            break;
        case BLOCK_LANTERN:
            lightColor = vec3(0.906, 0.737, 0.451);
            break;
        case BLOCK_LIGHT_1:
        case BLOCK_LIGHT_2:
        case BLOCK_LIGHT_3:
        case BLOCK_LIGHT_4:
        case BLOCK_LIGHT_5:
        case BLOCK_LIGHT_6:
        case BLOCK_LIGHT_7:
        case BLOCK_LIGHT_8:
        case BLOCK_LIGHT_9:
        case BLOCK_LIGHT_10:
        case BLOCK_LIGHT_11:
        case BLOCK_LIGHT_12:
        case BLOCK_LIGHT_13:
        case BLOCK_LIGHT_14:
        case BLOCK_LIGHT_15:
            lightColor = vec3(1.0);
            break;
        case BLOCK_LIGHTING_ROD_POWERED:
            lightColor = vec3(0.870, 0.956, 0.975);
            break;
        case BLOCK_LAVA:
        case BLOCK_LAVA_CAULDRON:
            lightColor = vec3(0.804, 0.424, 0.149);
            break;
        case BLOCK_MAGMA:
            lightColor = vec3(0.747, 0.323, 0.110);
            break;
        case BLOCK_NETHER_PORTAL:
            lightColor = vec3(0.502, 0.165, 0.831);
            break;
        case BLOCK_FROGLIGHT_OCHRE:
            lightColor = vec3(0.768, 0.648, 0.108);
            break;
        case BLOCK_FROGLIGHT_PEARLESCENT:
            lightColor = vec3(0.737, 0.435, 0.658);
            break;
        case BLOCK_REDSTONE_LAMP_LIT:
            lightColor = vec3(0.953, 0.796, 0.496);
            break;
        case BLOCK_REDSTONE_TORCH_LIT:
        case BLOCK_COMPARATOR_LIT:
        case BLOCK_REPEATER_LIT:
        case BLOCK_REDSTONE_WIRE_1:
        case BLOCK_REDSTONE_WIRE_2:
        case BLOCK_REDSTONE_WIRE_3:
        case BLOCK_REDSTONE_WIRE_4:
        case BLOCK_REDSTONE_WIRE_5:
        case BLOCK_REDSTONE_WIRE_6:
        case BLOCK_REDSTONE_WIRE_7:
        case BLOCK_REDSTONE_WIRE_8:
        case BLOCK_REDSTONE_WIRE_9:
        case BLOCK_REDSTONE_WIRE_10:
        case BLOCK_REDSTONE_WIRE_11:
        case BLOCK_REDSTONE_WIRE_12:
        case BLOCK_REDSTONE_WIRE_13:
        case BLOCK_REDSTONE_WIRE_14:
        case BLOCK_REDSTONE_WIRE_15:
        case BLOCK_RAIL_POWERED:
            lightColor = vec3(0.697, 0.130, 0.051);
            break;
        case BLOCK_RESPAWN_ANCHOR_4:
        case BLOCK_RESPAWN_ANCHOR_3:
        case BLOCK_RESPAWN_ANCHOR_2:
        case BLOCK_RESPAWN_ANCHOR_1:
            lightColor = vec3(0.390, 0.065, 0.646);
            break;
        case BLOCK_SCULK_CATALYST:
            lightColor = vec3(0.510, 0.831, 0.851);
            break;
        case BLOCK_SEA_LANTERN:
            lightColor = vec3(0.498, 0.894, 0.834);
            break;
        case BLOCK_SEA_PICKLE_WET_1:
        case BLOCK_SEA_PICKLE_WET_2:
        case BLOCK_SEA_PICKLE_WET_3:
        case BLOCK_SEA_PICKLE_WET_4:
            lightColor = vec3(0.283, 0.394, 0.212);
            break;
        case BLOCK_SHROOMLIGHT:
            lightColor = vec3(0.848, 0.469, 0.205);
            break;
        case BLOCK_SMOKER_LIT_N:
        case BLOCK_SMOKER_LIT_E:
        case BLOCK_SMOKER_LIT_S:
        case BLOCK_SMOKER_LIT_W:
            lightColor = vec3(0.697, 0.654, 0.458);
            break;
        case BLOCK_SOUL_LANTERN:
        case BLOCK_SOUL_TORCH:
        case BLOCK_SOUL_CAMPFIRE_LIT:
        case BLOCK_SOUL_FIRE:
            lightColor = vec3(0.203, 0.725, 0.758);
            break;
        case BLOCK_TORCH:
            lightColor = vec3(0.768, 0.701, 0.325);
            break;
        case BLOCK_FROGLIGHT_VERDANT:
            lightColor = vec3(0.463, 0.763, 0.409);
            break;
    }
    
    lightColor = RGBToLinear(lightColor);

    #ifdef DYN_LIGHT_FLICKER
        // TODO: optimize branching
        //vec2 noiseSample = GetDynLightNoise(cameraPosition + blockLocalPos);
        float flickerNoise = GetDynLightFlickerNoise(noiseSample);

        if (lightType == BLOCK_TORCH || lightType == BLOCK_LANTERN || lightType == BLOCK_FIRE || lightType == BLOCK_CAMPFIRE_LIT) {
            float torchTemp = mix(1600, 3400, flickerNoise);
            lightColor = 0.8 * blackbody(torchTemp);
        }

        if (lightType == BLOCK_SOUL_TORCH || lightType == BLOCK_SOUL_LANTERN || lightType == BLOCK_SOUL_FIRE || lightType == BLOCK_SOUL_CAMPFIRE_LIT) {
            float soulTorchTemp = mix(1200, 1800, 1.0 - flickerNoise);
            lightColor = 0.8 * saturate(1.0 - blackbody(soulTorchTemp));
        }

        if (lightType == BLOCK_CANDLES_LIT_1 || lightType == BLOCK_CANDLES_LIT_2
         || lightType == BLOCK_CANDLES_LIT_3 || lightType == BLOCK_CANDLES_LIT_4
         || lightType == BLOCK_CANDLE_CAKE_LIT || (lightType >= BLOCK_JACK_O_LANTERN_N && lightType <= BLOCK_JACK_O_LANTERN_W)) {
            float candleTemp = mix(2600, 3600, flickerNoise);
            lightColor = 0.7 * blackbody(candleTemp);
        }
    #endif

    return lightColor;
}

float GetSceneBlockLightRange(const in uint lightType) {
    float lightRange = 0.0;

    switch (lightType) {
        case BLOCK_AMETHYST_CLUSTER:
            lightRange = 5.0;
            break;
        case BLOCK_BEACON:
            lightRange = 15.0;
            break;
        case BLOCK_BLAST_FURNACE_LIT_N:
        case BLOCK_BLAST_FURNACE_LIT_E:
        case BLOCK_BLAST_FURNACE_LIT_S:
        case BLOCK_BLAST_FURNACE_LIT_W:
            lightRange = 6.0;
            break;
        case BLOCK_BREWING_STAND:
            lightRange = 1.0;
            break;
        case BLOCK_CANDLES_LIT_1:
            lightRange = 3.0;
            break;
        case BLOCK_CANDLES_LIT_2:
            lightRange = 6.0;
            break;
        case BLOCK_CANDLES_LIT_3:
            lightRange = 9.0;
            break;
        case BLOCK_CANDLES_LIT_4:
            lightRange = 12.0;
            break;
        case BLOCK_CANDLE_CAKE_LIT:
            lightRange = 3.0;
            break;
        case BLOCK_CAVEVINE_BERRIES:
            lightRange = 14.0;
            break;
        case BLOCK_CRYING_OBSIDIAN:
            lightRange = 10.0;
            break;
        case BLOCK_END_ROD:
            lightRange = 14.0;
            break;
        case BLOCK_CAMPFIRE_LIT:
        case BLOCK_FIRE:
            lightRange = 15.0;
            break;
        case BLOCK_FURNACE_LIT_N:
        case BLOCK_FURNACE_LIT_E:
        case BLOCK_FURNACE_LIT_S:
        case BLOCK_FURNACE_LIT_W:
            lightRange = 6.0;
            break;
        case BLOCK_GLOWSTONE:
            lightRange = 15.0;
            break;
        case BLOCK_GLOW_LICHEN:
            lightRange = 7.0;
            break;
        case BLOCK_JACK_O_LANTERN_N:
        case BLOCK_JACK_O_LANTERN_E:
        case BLOCK_JACK_O_LANTERN_S:
        case BLOCK_JACK_O_LANTERN_W:
            lightRange = 15.0;
            break;
        case BLOCK_LANTERN:
            lightRange = 12.0;
            break;
        case BLOCK_LAVA_CAULDRON:
            lightRange = 15.0;
            break;
        case BLOCK_LIGHTING_ROD_POWERED:
            lightRange = 8.0;
            break;

        case BLOCK_LIGHT_1:
            lightRange = 1.0;
            break;
        case BLOCK_LIGHT_2:
            lightRange = 2.0;
            break;
        case BLOCK_LIGHT_3:
            lightRange = 3.0;
            break;
        case BLOCK_LIGHT_4:
            lightRange = 4.0;
            break;
        case BLOCK_LIGHT_5:
            lightRange = 5.0;
            break;
        case BLOCK_LIGHT_6:
            lightRange = 6.0;
            break;
        case BLOCK_LIGHT_7:
            lightRange = 7.0;
            break;
        case BLOCK_LIGHT_8:
            lightRange = 8.0;
            break;
        case BLOCK_LIGHT_9:
            lightRange = 9.0;
            break;
        case BLOCK_LIGHT_10:
            lightRange = 10.0;
            break;
        case BLOCK_LIGHT_11:
            lightRange = 11.0;
            break;
        case BLOCK_LIGHT_12:
            lightRange = 12.0;
            break;
        case BLOCK_LIGHT_13:
            lightRange = 13.0;
            break;
        case BLOCK_LIGHT_14:
            lightRange = 14.0;
            break;
        case BLOCK_LIGHT_15:
            lightRange = 15.0;
            break;

        case BLOCK_AMETHYST_BUD_LARGE:
            lightRange = 4.0;
            break;
        case BLOCK_MAGMA:
            lightRange = 3.0;
            break;
        case BLOCK_AMETHYST_BUD_MEDIUM:
            lightRange = 2.0;
            break;
        case BLOCK_NETHER_PORTAL:
            lightRange = 11.0;
            break;
        case BLOCK_FROGLIGHT_OCHRE:
            lightRange = 15.0;
            break;
        case BLOCK_FROGLIGHT_PEARLESCENT:
            lightRange = 15.0;
            break;
        case BLOCK_REDSTONE_LAMP_LIT:
            lightRange = 15.0;
            break;
        case BLOCK_REDSTONE_TORCH_LIT:
            lightRange = 7.0;
            break;
        case BLOCK_RESPAWN_ANCHOR_4:
            lightRange = 15.0;
            break;
        case BLOCK_RESPAWN_ANCHOR_3:
            lightRange = 11.0;
            break;
        case BLOCK_RESPAWN_ANCHOR_2:
            lightRange = 7.0;
            break;
        case BLOCK_RESPAWN_ANCHOR_1:
            lightRange = 3.0;
            break;
        case BLOCK_SCULK_CATALYST:
            lightRange = 6.0;
            break;
        case BLOCK_SEA_LANTERN:
            lightRange = 15.0;
            break;
        case BLOCK_SEA_PICKLE_WET_1:
            lightRange = 6.0;
            break;
        case BLOCK_SEA_PICKLE_WET_2:
            lightRange = 9.0;
            break;
        case BLOCK_SEA_PICKLE_WET_3:
            lightRange = 12.0;
            break;
        case BLOCK_SEA_PICKLE_WET_4:
            lightRange = 15.0;
            break;
        case BLOCK_SHROOMLIGHT:
            lightRange = 15.0;
            break;
        case BLOCK_SMOKER_LIT_N:
        case BLOCK_SMOKER_LIT_E:
        case BLOCK_SMOKER_LIT_S:
        case BLOCK_SMOKER_LIT_W:
            lightRange = 6.0;
            break;
        case BLOCK_SOUL_CAMPFIRE_LIT:
        case BLOCK_SOUL_FIRE:
        case BLOCK_SOUL_LANTERN:
            lightRange = 12.0;
            break;
        case BLOCK_SOUL_TORCH:
            lightRange = 12.0;
            break;
        case BLOCK_TORCH:
            lightRange = 12.0;
            break;
        case BLOCK_FROGLIGHT_VERDANT:
            lightRange = 15.0;
            break;

        case BLOCK_RAIL_POWERED:
            lightRange = 3.0;
            break;

        case BLOCK_COMPARATOR_LIT:
        case BLOCK_REPEATER_LIT:
            lightRange = 7.0;
            break;
        case BLOCK_REDSTONE_WIRE_1:
            lightRange = 1.0;
            break;
        case BLOCK_REDSTONE_WIRE_2:
            lightRange = 1.5;
            break;
        case BLOCK_REDSTONE_WIRE_3:
            lightRange = 2.0;
            break;
        case BLOCK_REDSTONE_WIRE_4:
            lightRange = 2.5;
            break;
        case BLOCK_REDSTONE_WIRE_5:
            lightRange = 3.0;
            break;
        case BLOCK_REDSTONE_WIRE_6:
            lightRange = 3.5;
            break;
        case BLOCK_REDSTONE_WIRE_7:
            lightRange = 4.0;
            break;
        case BLOCK_REDSTONE_WIRE_8:
            lightRange = 4.5;
            break;
        case BLOCK_REDSTONE_WIRE_9:
            lightRange = 5.0;
            break;
        case BLOCK_REDSTONE_WIRE_10:
            lightRange = 5.5;
            break;
        case BLOCK_REDSTONE_WIRE_11:
            lightRange = 6.0;
            break;
        case BLOCK_REDSTONE_WIRE_12:
            lightRange = 6.5;
            break;
        case BLOCK_REDSTONE_WIRE_13:
            lightRange = 7.0;
            break;
        case BLOCK_REDSTONE_WIRE_14:
            lightRange = 7.5;
            break;
        case BLOCK_REDSTONE_WIRE_15:
            lightRange = 8.0;
            break;
    
        case BLOCK_LAVA:
            lightRange = 8.0;
            break;
    }

    return lightRange;
}

float GetSceneBlockLightLevel(const in uint lightType) {
    #if DYN_LIGHT_REDSTONE == 0
        if (lightType == BLOCK_COMPARATOR_LIT
         || lightType == BLOCK_REPEATER_LIT
         || lightType == BLOCK_RAIL_POWERED) return 0.0;

        if (lightType >= BLOCK_REDSTONE_WIRE_1
         && lightType <= BLOCK_REDSTONE_WIRE_15) return 0.0;
    #endif
    
    #if DYN_LIGHT_LAVA == 0
        if (lightType == BLOCK_LAVA) return 0.0;
    #endif

    return GetSceneBlockLightRange(lightType);
}

float GetSceneBlockEmission(const in uint lightType) {
    float range = GetSceneBlockLightRange(lightType);

    if (lightType == BLOCK_LAVA) range *= 2.0;
    if (lightType == BLOCK_CAVEVINE_BERRIES) range = 0.0;

    return range / 15.0;
}

float GetSceneBlockLightSize(const in uint lightType) {
    float size = 0.1;

    switch (lightType) {
        case BLOCK_CRYING_OBSIDIAN:
        case BLOCK_FIRE:
        case BLOCK_FROGLIGHT_OCHRE:
        case BLOCK_FROGLIGHT_PEARLESCENT:
        case BLOCK_FROGLIGHT_VERDANT:
        case BLOCK_GLOWSTONE:
        case BLOCK_LAVA:
        case BLOCK_MAGMA:
        case BLOCK_SEA_LANTERN:
        case BLOCK_SHROOMLIGHT:
        case BLOCK_SOUL_FIRE:
            size = 1.0;
            break;
        case BLOCK_REDSTONE_LAMP_LIT:
            size = 0.9;
            break;
        case BLOCK_CAMPFIRE_LIT:
        case BLOCK_SOUL_CAMPFIRE_LIT:
        case BLOCK_LAVA_CAULDRON:
            size = 0.8;
            break;
        case BLOCK_BEACON:
        case BLOCK_JACK_O_LANTERN_N:
        case BLOCK_JACK_O_LANTERN_E:
        case BLOCK_JACK_O_LANTERN_S:
        case BLOCK_JACK_O_LANTERN_W:
        case BLOCK_RAIL_POWERED:
            size = 0.6;
            break;
        case BLOCK_END_ROD:
            size = 0.5;
        case BLOCK_LANTERN:
        case BLOCK_SOUL_LANTERN:
        case BLOCK_CANDLES_LIT_4:
            size = 0.4;
            break;
        case BLOCK_CANDLES_LIT_3:
            size = 0.3;
            break;
        case BLOCK_TORCH:
        case BLOCK_SOUL_TORCH:
        case BLOCK_CANDLES_LIT_2:
            size = 0.2;
            break;
        case BLOCK_CANDLES_LIT_1:
            size = 0.1;
            break;
    }

    #if DYN_LIGHT_LAVA != 2
        if (lightType == BLOCK_LAVA) size = 0.0;
    #endif

    #if DYN_LIGHT_REDSTONE != 2
        if (lightType >= BLOCK_REDSTONE_WIRE_1 && lightType <= BLOCK_REDSTONE_WIRE_15) size = 0.0;
    #endif

    //if (lightType == BLOCK_CAVEVINE_BERRIES) size = 0.4;

    return size;
}

#ifdef RENDER_SHADOW
    #if DYN_LIGHT_MODE == DYN_LIGHT_TRACED
        uint GetBlockType(const in int blockId) {
            uint blockType = BLOCKTYPE_SOLID;
            if (blockId < 1) return blockType;

            switch (blockId) {
                case BLOCK_ANVIL_N_S:
                    blockType = BLOCKTYPE_ANVIL_N_S;
                    break;
                case BLOCK_ANVIL_W_E:
                    blockType = BLOCKTYPE_ANVIL_W_E;
                    break;

                case BLOCK_BELL_FLOOR_N_S:
                case BLOCK_BELL_WALL_N:
                case BLOCK_BELL_WALL_S:
                case BLOCK_BELL_WALL_N_S:
                case BLOCK_BELL_CEILING:
                    blockType = BLOCKTYPE_BELL_FLOOR_N_S;
                    break;
                case BLOCK_BELL_FLOOR_W_E:
                case BLOCK_BELL_WALL_W:
                case BLOCK_BELL_WALL_E:
                case BLOCK_BELL_WALL_W_E:
                    blockType = BLOCKTYPE_BELL_FLOOR_W_E;
                    break;

                case BLOCK_CACTUS:
                    blockType = BLOCKTYPE_CACTUS;
                    break;

                case BLOCK_CAKE:
                    blockType = BLOCKTYPE_CAKE;
                    break;

                case BLOCK_CAMPFIRE_N_S:
                    blockType = BLOCKTYPE_CAMPFIRE_N_S;
                    break;
                case BLOCK_CAMPFIRE_W_E:
                    blockType = BLOCKTYPE_CAMPFIRE_W_E;
                    break;

                case BLOCK_CANDLE_CAKE:
                    blockType = BLOCKTYPE_CANDLE_CAKE;
                    break;

                case BLOCK_CARPET:
                    blockType = BLOCKTYPE_CARPET;
                    break;

                case BLOCK_COMPARATOR:
                    blockType = BLOCKTYPE_LAYERS_2;
                    break;

                case BLOCK_DAYLIGHT_DETECTOR:
                    blockType = BLOCKTYPE_LAYERS_6;
                    break;

                case BLOCK_ENCHANTING_TABLE:
                    blockType = BLOCKTYPE_LAYERS_12;
                    break;
                case BLOCK_END_PORTAL_FRAME:
                    blockType = BLOCKTYPE_END_PORTAL_FRAME;
                    break;
                case BLOCK_FLOWER_POT:
                case BLOCK_POTTED_PLANT:
                    blockType = BLOCKTYPE_FLOWER_POT;
                    break;
                case BLOCK_GRINDSTONE_FLOOR_N_S:
                    blockType = BLOCKTYPE_GRINDSTONE_FLOOR_N_S;
                    break;
                case BLOCK_GRINDSTONE_FLOOR_W_E:
                    blockType = BLOCKTYPE_GRINDSTONE_FLOOR_W_E;
                    break;
                case BLOCK_GRINDSTONE_WALL_N_S:
                    blockType = BLOCKTYPE_GRINDSTONE_WALL_N_S;
                    break;
                case BLOCK_GRINDSTONE_WALL_W_E:
                    blockType = BLOCKTYPE_GRINDSTONE_WALL_W_E;
                    break;
                case BLOCK_HOPPER_DOWN:
                    blockType = BLOCKTYPE_HOPPER_DOWN;
                    break;
                case BLOCK_HOPPER_N:
                    blockType = BLOCKTYPE_HOPPER_N;
                    break;
                case BLOCK_HOPPER_E:
                    blockType = BLOCKTYPE_HOPPER_E;
                    break;
                case BLOCK_HOPPER_S:
                    blockType = BLOCKTYPE_HOPPER_S;
                    break;
                case BLOCK_HOPPER_W:
                    blockType = BLOCKTYPE_HOPPER_W;
                    break;
                case BLOCK_LECTERN:
                    blockType = BLOCKTYPE_LECTERN;
                    break;
                case BLOCK_LIGHTNING_ROD_N:
                    blockType = BLOCKTYPE_LIGHTNING_ROD_N;
                    break;
                case BLOCK_LIGHTNING_ROD_E:
                    blockType = BLOCKTYPE_LIGHTNING_ROD_E;
                    break;
                case BLOCK_LIGHTNING_ROD_S:
                    blockType = BLOCKTYPE_LIGHTNING_ROD_S;
                    break;
                case BLOCK_LIGHTNING_ROD_W:
                    blockType = BLOCKTYPE_LIGHTNING_ROD_W;
                    break;
                case BLOCK_LIGHTNING_ROD_UP:
                    blockType = BLOCKTYPE_LIGHTNING_ROD_UP;
                    break;
                case BLOCK_LIGHTNING_ROD_DOWN:
                    blockType = BLOCKTYPE_LIGHTNING_ROD_DOWN;
                    break;
                case BLOCK_PATHWAY:
                    blockType = BLOCKTYPE_PATHWAY;
                    break;
                case BLOCK_PISTON_EXTENDED_N:
                    blockType = BLOCKTYPE_PISTON_EXTENDED_N;
                    break;
                case BLOCK_PISTON_EXTENDED_E:
                    blockType = BLOCKTYPE_PISTON_EXTENDED_E;
                    break;
                case BLOCK_PISTON_EXTENDED_S:
                    blockType = BLOCKTYPE_PISTON_EXTENDED_S;
                    break;
                case BLOCK_PISTON_EXTENDED_W:
                    blockType = BLOCKTYPE_PISTON_EXTENDED_W;
                    break;
                case BLOCK_PISTON_EXTENDED_UP:
                    blockType = BLOCKTYPE_PISTON_EXTENDED_UP;
                    break;
                case BLOCK_PISTON_EXTENDED_DOWN:
                    blockType = BLOCKTYPE_PISTON_EXTENDED_DOWN;
                    break;
                case BLOCK_PISTON_HEAD_N:
                    blockType = BLOCKTYPE_PISTON_HEAD_N;
                    break;
                case BLOCK_PISTON_HEAD_E:
                    blockType = BLOCKTYPE_PISTON_HEAD_E;
                    break;
                case BLOCK_PISTON_HEAD_S:
                    blockType = BLOCKTYPE_PISTON_HEAD_S;
                    break;
                case BLOCK_PISTON_HEAD_W:
                    blockType = BLOCKTYPE_PISTON_HEAD_W;
                    break;
                case BLOCK_PISTON_HEAD_UP:
                    blockType = BLOCKTYPE_PISTON_HEAD_UP;
                    break;
                case BLOCK_PISTON_HEAD_DOWN:
                    blockType = BLOCKTYPE_PISTON_HEAD_DOWN;
                    break;
                case BLOCK_PRESSURE_PLATE:
                    blockType = BLOCKTYPE_PRESSURE_PLATE;
                    break;
                case BLOCK_REPEATER:
                    blockType = BLOCKTYPE_LAYERS_2;
                    break;
                case BLOCK_STONECUTTER:
                    blockType = BLOCKTYPE_STONECUTTER;
                    break;

                case BLOCK_SNOW_LAYERS_1:
                    blockType = BLOCKTYPE_LAYERS_2;
                    break;
                case BLOCK_SNOW_LAYERS_2:
                    blockType = BLOCKTYPE_LAYERS_4;
                    break;
                case BLOCK_SNOW_LAYERS_3:
                    blockType = BLOCKTYPE_LAYERS_6;
                    break;
                case BLOCK_SNOW_LAYERS_4:
                    blockType = BLOCKTYPE_LAYERS_8;
                    break;
                case BLOCK_SNOW_LAYERS_5:
                    blockType = BLOCKTYPE_LAYERS_10;
                    break;
                case BLOCK_SNOW_LAYERS_6:
                    blockType = BLOCKTYPE_LAYERS_12;
                    break;
                case BLOCK_SNOW_LAYERS_7:
                    blockType = BLOCKTYPE_LAYERS_14;
                    break;
            }
                    
            switch (blockId) {
                case BLOCK_BUTTON_FLOOR_N_S:
                    blockType = BLOCKTYPE_BUTTON_FLOOR_N_S;
                    break;
                case BLOCK_BUTTON_FLOOR_W_E:
                    blockType = BLOCKTYPE_BUTTON_FLOOR_W_E;
                    break;
                case BLOCK_BUTTON_CEILING_N_S:
                    blockType = BLOCKTYPE_BUTTON_CEILING_N_S;
                    break;
                case BLOCK_BUTTON_CEILING_W_E:
                    blockType = BLOCKTYPE_BUTTON_CEILING_W_E;
                    break;
                case BLOCK_BUTTON_WALL_N:
                    blockType = BLOCKTYPE_BUTTON_WALL_N;
                    break;
                case BLOCK_BUTTON_WALL_E:
                    blockType = BLOCKTYPE_BUTTON_WALL_E;
                    break;
                case BLOCK_BUTTON_WALL_S:
                    blockType = BLOCKTYPE_BUTTON_WALL_S;
                    break;
                case BLOCK_BUTTON_WALL_W:
                    blockType = BLOCKTYPE_BUTTON_WALL_W;
                    break;

                case BLOCK_DOOR_N:
                    blockType = BLOCKTYPE_DOOR_N;
                    break;
                case BLOCK_DOOR_E:
                    blockType = BLOCKTYPE_DOOR_E;
                    break;
                case BLOCK_DOOR_S:
                    blockType = BLOCKTYPE_DOOR_S;
                    break;
                case BLOCK_DOOR_W:
                    blockType = BLOCKTYPE_DOOR_W;
                    break;

                case BLOCK_LEVER_FLOOR_N_S:
                    blockType = BLOCKTYPE_LEVER_FLOOR_N_S;
                    break;
                case BLOCK_LEVER_FLOOR_W_E:
                    blockType = BLOCKTYPE_LEVER_FLOOR_W_E;
                    break;
                case BLOCK_LEVER_CEILING_N_S:
                    blockType = BLOCKTYPE_LEVER_CEILING_N_S;
                    break;
                case BLOCK_LEVER_CEILING_W_E:
                    blockType = BLOCKTYPE_LEVER_CEILING_W_E;
                    break;
                case BLOCK_LEVER_WALL_N:
                    blockType = BLOCKTYPE_LEVER_WALL_N;
                    break;
                case BLOCK_LEVER_WALL_E:
                    blockType = BLOCKTYPE_LEVER_WALL_E;
                    break;
                case BLOCK_LEVER_WALL_S:
                    blockType = BLOCKTYPE_LEVER_WALL_S;
                    break;
                case BLOCK_LEVER_WALL_W:
                    blockType = BLOCKTYPE_LEVER_WALL_W;
                    break;

                case BLOCK_TRAPDOOR_BOTTOM:
                    blockType = BLOCKTYPE_TRAPDOOR_BOTTOM;
                    break;
                case BLOCK_TRAPDOOR_TOP:
                    blockType = BLOCKTYPE_TRAPDOOR_TOP;
                    break;
                case BLOCK_TRAPDOOR_N:
                    blockType = BLOCKTYPE_TRAPDOOR_N;
                    break;
                case BLOCK_TRAPDOOR_E:
                    blockType = BLOCKTYPE_TRAPDOOR_E;
                    break;
                case BLOCK_TRAPDOOR_S:
                    blockType = BLOCKTYPE_TRAPDOOR_S;
                    break;
                case BLOCK_TRAPDOOR_W:
                    blockType = BLOCKTYPE_TRAPDOOR_W;
                    break;

                case BLOCK_TRIPWIRE_HOOK_N:
                    blockType = BLOCKTYPE_TRIPWIRE_HOOK_N;
                    break;
                case BLOCK_TRIPWIRE_HOOK_E:
                    blockType = BLOCKTYPE_TRIPWIRE_HOOK_E;
                    break;
                case BLOCK_TRIPWIRE_HOOK_S:
                    blockType = BLOCKTYPE_TRIPWIRE_HOOK_S;
                    break;
                case BLOCK_TRIPWIRE_HOOK_W:
                    blockType = BLOCKTYPE_TRIPWIRE_HOOK_W;
                    break;

                case BLOCK_SLABS_BOTTOM:
                case BLOCK_SCULK_SENSOR:
                case BLOCK_SCULK_SHRIEKER:
                    blockType = BLOCKTYPE_LAYERS_8;
                    break;
                case BLOCK_SLABS_TOP:
                    blockType = BLOCKTYPE_SLAB_TOP;
                    break;

                case BLOCK_STAIRS_BOTTOM_N:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_N;
                    break;
                case BLOCK_STAIRS_BOTTOM_E:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_E;
                    break;
                case BLOCK_STAIRS_BOTTOM_S:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_S;
                    break;
                case BLOCK_STAIRS_BOTTOM_W:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_W;
                    break;
                case BLOCK_STAIRS_BOTTOM_INNER_N_W:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_INNER_N_W;
                    break;
                case BLOCK_STAIRS_BOTTOM_INNER_N_E:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_INNER_N_E;
                    break;
                case BLOCK_STAIRS_BOTTOM_INNER_S_W:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_INNER_S_W;
                    break;
                case BLOCK_STAIRS_BOTTOM_INNER_S_E:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_INNER_S_E;
                    break;
                case BLOCK_STAIRS_BOTTOM_OUTER_N_W:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_OUTER_N_W;
                    break;
                case BLOCK_STAIRS_BOTTOM_OUTER_N_E:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_OUTER_N_E;
                    break;
                case BLOCK_STAIRS_BOTTOM_OUTER_S_W:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_OUTER_S_W;
                    break;
                case BLOCK_STAIRS_BOTTOM_OUTER_S_E:
                    blockType = BLOCKTYPE_STAIRS_BOTTOM_OUTER_S_E;
                    break;
                case BLOCK_STAIRS_TOP_N:
                    blockType = BLOCKTYPE_STAIRS_TOP_N;
                    break;
                case BLOCK_STAIRS_TOP_E:
                    blockType = BLOCKTYPE_STAIRS_TOP_E;
                    break;
                case BLOCK_STAIRS_TOP_S:
                    blockType = BLOCKTYPE_STAIRS_TOP_S;
                    break;
                case BLOCK_STAIRS_TOP_W:
                    blockType = BLOCKTYPE_STAIRS_TOP_W;
                    break;
                case BLOCK_STAIRS_TOP_INNER_N_W:
                    blockType = BLOCKTYPE_STAIRS_TOP_INNER_N_W;
                    break;
                case BLOCK_STAIRS_TOP_INNER_N_E:
                    blockType = BLOCKTYPE_STAIRS_TOP_INNER_N_E;
                    break;
                case BLOCK_STAIRS_TOP_INNER_S_W:
                    blockType = BLOCKTYPE_STAIRS_TOP_INNER_S_W;
                    break;
                case BLOCK_STAIRS_TOP_INNER_S_E:
                    blockType = BLOCKTYPE_STAIRS_TOP_INNER_S_E;
                    break;
                case BLOCK_STAIRS_TOP_OUTER_N_W:
                    blockType = BLOCKTYPE_STAIRS_TOP_OUTER_N_W;
                    break;
                case BLOCK_STAIRS_TOP_OUTER_N_E:
                    blockType = BLOCKTYPE_STAIRS_TOP_OUTER_N_E;
                    break;
                case BLOCK_STAIRS_TOP_OUTER_S_W:
                    blockType = BLOCKTYPE_STAIRS_TOP_OUTER_S_W;
                    break;
                case BLOCK_STAIRS_TOP_OUTER_S_E:
                    blockType = BLOCKTYPE_STAIRS_TOP_OUTER_S_E;
                    break;
            }

            switch (blockId) {
                case BLOCK_FENCE_POST:
                    blockType = BLOCKTYPE_FENCE_POST;
                    break;
                case BLOCK_FENCE_N:
                    blockType = BLOCKTYPE_FENCE_N;
                    break;
                case BLOCK_FENCE_E:
                    blockType = BLOCKTYPE_FENCE_E;
                    break;
                case BLOCK_FENCE_S:
                    blockType = BLOCKTYPE_FENCE_S;
                    break;
                case BLOCK_FENCE_W:
                    blockType = BLOCKTYPE_FENCE_W;
                    break;
                case BLOCK_FENCE_N_S:
                    blockType = BLOCKTYPE_FENCE_N_S;
                    break;
                case BLOCK_FENCE_W_E:
                    blockType = BLOCKTYPE_FENCE_W_E;
                    break;
                case BLOCK_FENCE_N_W:
                    blockType = BLOCKTYPE_FENCE_N_W;
                    break;
                case BLOCK_FENCE_N_E:
                    blockType = BLOCKTYPE_FENCE_N_E;
                    break;
                case BLOCK_FENCE_S_W:
                    blockType = BLOCKTYPE_FENCE_S_W;
                    break;
                case BLOCK_FENCE_S_E:
                    blockType = BLOCKTYPE_FENCE_S_E;
                    break;
                case BLOCK_FENCE_W_N_E:
                    blockType = BLOCKTYPE_FENCE_W_N_E;
                    break;
                case BLOCK_FENCE_W_S_E:
                    blockType = BLOCKTYPE_FENCE_W_S_E;
                    break;
                case BLOCK_FENCE_N_W_S:
                    blockType = BLOCKTYPE_FENCE_N_W_S;
                    break;
                case BLOCK_FENCE_N_E_S:
                    blockType = BLOCKTYPE_FENCE_N_E_S;
                    break;
                case BLOCK_FENCE_ALL:
                    blockType = BLOCKTYPE_FENCE_ALL;
                    break;

                case BLOCK_FENCE_GATE_CLOSED_N_S:
                    blockType = BLOCKTYPE_FENCE_GATE_CLOSED_N_S;
                    break;
                case BLOCK_FENCE_GATE_CLOSED_W_E:
                    blockType = BLOCKTYPE_FENCE_GATE_CLOSED_W_E;
                    break;
            }

            switch (blockId) {
                case BLOCK_WALL_POST:
                    blockType = BLOCKTYPE_WALL_POST;
                    break;
                case BLOCK_WALL_POST_LOW_N:
                    blockType = BLOCKTYPE_WALL_POST_LOW_N;
                    break;
                case BLOCK_WALL_POST_LOW_E:
                    blockType = BLOCKTYPE_WALL_POST_LOW_E;
                    break;
                case BLOCK_WALL_POST_LOW_S:
                    blockType = BLOCKTYPE_WALL_POST_LOW_S;
                    break;
                case BLOCK_WALL_POST_LOW_W:
                    blockType = BLOCKTYPE_WALL_POST_LOW_W;
                    break;
                case BLOCK_WALL_POST_LOW_N_S:
                    blockType = BLOCKTYPE_WALL_POST_LOW_N_S;
                    break;
                case BLOCK_WALL_POST_LOW_W_E:
                    blockType = BLOCKTYPE_WALL_POST_LOW_W_E;
                    break;
                case BLOCK_WALL_POST_LOW_N_W:
                    blockType = BLOCKTYPE_WALL_POST_LOW_N_W;
                    break;
                case BLOCK_WALL_POST_LOW_N_E:
                    blockType = BLOCKTYPE_WALL_POST_LOW_N_E;
                    break;
                case BLOCK_WALL_POST_LOW_S_W:
                    blockType = BLOCKTYPE_WALL_POST_LOW_S_W;
                    break;
                case BLOCK_WALL_POST_LOW_S_E:
                    blockType = BLOCKTYPE_WALL_POST_LOW_S_E;
                    break;
                case BLOCK_WALL_POST_LOW_N_W_S:
                    blockType = BLOCKTYPE_WALL_POST_LOW_N_W_S;
                    break;
                case BLOCK_WALL_POST_LOW_N_E_S:
                    blockType = BLOCKTYPE_WALL_POST_LOW_N_E_S;
                    break;
                case BLOCK_WALL_POST_LOW_W_N_E:
                    blockType = BLOCKTYPE_WALL_POST_LOW_W_N_E;
                    break;
                case BLOCK_WALL_POST_LOW_W_S_E:
                    blockType = BLOCKTYPE_WALL_POST_LOW_W_S_E;
                    break;
                case BLOCK_WALL_POST_LOW_ALL:
                    blockType = BLOCKTYPE_WALL_POST_LOW_ALL;
                    break;
                case BLOCK_WALL_POST_TALL_N:
                    blockType = BLOCKTYPE_WALL_POST_TALL_N;
                    break;
                case BLOCK_WALL_POST_TALL_E:
                    blockType = BLOCKTYPE_WALL_POST_TALL_E;
                    break;
                case BLOCK_WALL_POST_TALL_S:
                    blockType = BLOCKTYPE_WALL_POST_TALL_S;
                    break;
                case BLOCK_WALL_POST_TALL_W:
                    blockType = BLOCKTYPE_WALL_POST_TALL_W;
                    break;
                case BLOCK_WALL_POST_TALL_N_S:
                    blockType = BLOCKTYPE_WALL_POST_TALL_N_S;
                    break;
                case BLOCK_WALL_POST_TALL_W_E:
                    blockType = BLOCKTYPE_WALL_POST_TALL_W_E;
                    break;
                case BLOCK_WALL_POST_TALL_N_W:
                    blockType = BLOCKTYPE_WALL_POST_TALL_N_W;
                    break;
                case BLOCK_WALL_POST_TALL_N_E:
                    blockType = BLOCKTYPE_WALL_POST_TALL_N_E;
                    break;
                case BLOCK_WALL_POST_TALL_S_W:
                    blockType = BLOCKTYPE_WALL_POST_TALL_S_W;
                    break;
                case BLOCK_WALL_POST_TALL_S_E:
                    blockType = BLOCKTYPE_WALL_POST_TALL_S_E;
                    break;
                case BLOCK_WALL_POST_TALL_N_W_S:
                    blockType = BLOCKTYPE_WALL_POST_TALL_N_W_S;
                    break;
                case BLOCK_WALL_POST_TALL_N_E_S:
                    blockType = BLOCKTYPE_WALL_POST_TALL_N_E_S;
                    break;
                case BLOCK_WALL_POST_TALL_W_N_E:
                    blockType = BLOCKTYPE_WALL_POST_TALL_W_N_E;
                    break;
                case BLOCK_WALL_POST_TALL_W_S_E:
                    blockType = BLOCKTYPE_WALL_POST_TALL_W_S_E;
                    break;
                case BLOCK_WALL_POST_TALL_ALL:
                    blockType = BLOCKTYPE_WALL_POST_TALL_ALL;
                    break;
                case BLOCK_WALL_LOW_N_S:
                    blockType = BLOCKTYPE_WALL_LOW_N_S;
                    break;
                case BLOCK_WALL_LOW_W_E:
                    blockType = BLOCKTYPE_WALL_LOW_W_E;
                    break;
                case BLOCK_WALL_TALL_N_S:
                    blockType = BLOCKTYPE_WALL_TALL_N_S;
                    break;
                case BLOCK_WALL_TALL_W_E:
                    blockType = BLOCKTYPE_WALL_TALL_W_E;
                    break;

                case BLOCK_CHORUS_DOWN:
                    blockType = BLOCKTYPE_CHORUS_DOWN;
                    break;
                case BLOCK_CHORUS_UP_DOWN:
                    blockType = BLOCKTYPE_CHORUS_UP_DOWN;
                    break;
                case BLOCK_CHORUS_OTHER:
                    blockType = BLOCKTYPE_CHORUS_OTHER;
                    break;
            }

            switch (blockId) {
                case BLOCK_AMETHYST:
                    blockType = BLOCKTYPE_AMETHYST;
                    break;
                case BLOCK_DIAMOND:
                    blockType = BLOCKTYPE_DIAMOND;
                    break;
                case BLOCK_EMERALD:
                    blockType = BLOCKTYPE_EMERALD;
                    break;
                case BLOCK_HONEY:
                    blockType = BLOCKTYPE_HONEY;
                    break;
                case BLOCK_SLIME:
                    blockType = BLOCKTYPE_SLIME;
                    break;
                case BLOCK_SNOW:
                    blockType = BLOCKTYPE_SNOW;
                    break;
                case BLOCK_STAINED_GLASS_BLACK:
                    blockType = BLOCKTYPE_STAINED_GLASS_BLACK;
                    break;
                case BLOCK_STAINED_GLASS_BLUE:
                    blockType = BLOCKTYPE_STAINED_GLASS_BLUE;
                    break;
                case BLOCK_STAINED_GLASS_BROWN:
                    blockType = BLOCKTYPE_STAINED_GLASS_BROWN;
                    break;
                case BLOCK_STAINED_GLASS_CYAN:
                    blockType = BLOCKTYPE_STAINED_GLASS_CYAN;
                    break;
                case BLOCK_STAINED_GLASS_GRAY:
                    blockType = BLOCKTYPE_STAINED_GLASS_GRAY;
                    break;
                case BLOCK_STAINED_GLASS_GREEN:
                    blockType = BLOCKTYPE_STAINED_GLASS_GREEN;
                    break;
                case BLOCK_STAINED_GLASS_LIGHT_BLUE:
                    blockType = BLOCKTYPE_STAINED_GLASS_LIGHT_BLUE;
                    break;
                case BLOCK_STAINED_GLASS_LIGHT_GRAY:
                    blockType = BLOCKTYPE_STAINED_GLASS_LIGHT_GRAY;
                    break;
                case BLOCK_STAINED_GLASS_LIME:
                    blockType = BLOCKTYPE_STAINED_GLASS_LIME;
                    break;
                case BLOCK_STAINED_GLASS_MAGENTA:
                    blockType = BLOCKTYPE_STAINED_GLASS_MAGENTA;
                    break;
                case BLOCK_STAINED_GLASS_ORANGE:
                    blockType = BLOCKTYPE_STAINED_GLASS_ORANGE;
                    break;
                case BLOCK_STAINED_GLASS_PINK:
                    blockType = BLOCKTYPE_STAINED_GLASS_PINK;
                    break;
                case BLOCK_STAINED_GLASS_PURPLE:
                    blockType = BLOCKTYPE_STAINED_GLASS_PURPLE;
                    break;
                case BLOCK_STAINED_GLASS_RED:
                    blockType = BLOCKTYPE_STAINED_GLASS_RED;
                    break;
                case BLOCK_STAINED_GLASS_WHITE:
                case BLOCK_LEAVES:
                    blockType = BLOCKTYPE_STAINED_GLASS_WHITE;
                    break;
                case BLOCK_STAINED_GLASS_YELLOW:
                    blockType = BLOCKTYPE_STAINED_GLASS_YELLOW;
                    break;
            }

            return blockType;
        }
    #endif

    uint BuildBlockLightMask(const in uint lightType, const in float lightSize) {
        uint lightData;

        // trace
        lightData = lightSize > EPSILON ? 1u : 0u;

        switch (lightType) {
            case BLOCK_BEACON:
                lightData |= 1u << LIGHT_MASK_DOWN;
                break;
            case BLOCK_JACK_O_LANTERN_N:
            case BLOCK_FURNACE_LIT_N:
            case BLOCK_BLAST_FURNACE_LIT_N:
            case BLOCK_SMOKER_LIT_N:
                lightData |= 1u << LIGHT_MASK_UP;
                lightData |= 1u << LIGHT_MASK_DOWN;
                lightData |= 1u << LIGHT_MASK_SOUTH;
                lightData |= 1u << LIGHT_MASK_WEST;
                lightData |= 1u << LIGHT_MASK_EAST;
                break;
            case BLOCK_JACK_O_LANTERN_E:
            case BLOCK_FURNACE_LIT_E:
            case BLOCK_BLAST_FURNACE_LIT_E:
            case BLOCK_SMOKER_LIT_E:
                lightData |= 1u << LIGHT_MASK_UP;
                lightData |= 1u << LIGHT_MASK_DOWN;
                lightData |= 1u << LIGHT_MASK_NORTH;
                lightData |= 1u << LIGHT_MASK_SOUTH;
                lightData |= 1u << LIGHT_MASK_WEST;
                break;
            case BLOCK_JACK_O_LANTERN_S:
            case BLOCK_FURNACE_LIT_S:
            case BLOCK_BLAST_FURNACE_LIT_S:
            case BLOCK_SMOKER_LIT_S:
                lightData |= 1u << LIGHT_MASK_UP;
                lightData |= 1u << LIGHT_MASK_DOWN;
                lightData |= 1u << LIGHT_MASK_NORTH;
                lightData |= 1u << LIGHT_MASK_WEST;
                lightData |= 1u << LIGHT_MASK_EAST;
                break;
            case BLOCK_JACK_O_LANTERN_W:
            case BLOCK_FURNACE_LIT_W:
            case BLOCK_BLAST_FURNACE_LIT_W:
            case BLOCK_SMOKER_LIT_W:
                lightData |= 1u << LIGHT_MASK_UP;
                lightData |= 1u << LIGHT_MASK_DOWN;
                lightData |= 1u << LIGHT_MASK_NORTH;
                lightData |= 1u << LIGHT_MASK_SOUTH;
                lightData |= 1u << LIGHT_MASK_EAST;
                break;
            // case BLOCK_LANTERN:
            // case BLOCK_SOUL_LANTERN:
            //     lightData |= 1u << LIGHT_MASK_UP;
            //     lightData |= 1u << LIGHT_MASK_DOWN;
            //     break;
            case BLOCK_LAVA_CAULDRON:
                lightData |= 1u << LIGHT_MASK_DOWN;
                lightData |= 1u << LIGHT_MASK_NORTH;
                lightData |= 1u << LIGHT_MASK_SOUTH;
                lightData |= 1u << LIGHT_MASK_WEST;
                lightData |= 1u << LIGHT_MASK_EAST;
                break;
        }

        // size
        uint bitSize = uint(saturate(lightSize) * 31.0 + 0.5);
        lightData |= bitSize << 8u;

        return lightData;
    }

    // void AddSceneBlockLight(const in int blockId, const in vec3 blockLocalPos, const in vec3 lightColor, const in float lightRange) {
    //     vec3 lightOffset = vec3(0.0);
    //     vec3 lightColorFinal = lightColor;
        
    //     if (lightRange > EPSILON) {
    //         vec2 noiseSample = vec2(0.0);
    //         #ifdef DYN_LIGHT_FLICKER
    //             noiseSample = GetDynLightNoise(cameraPosition + blockLocalPos);
    //         #endif

    //         float flicker = 0.0;
    //         //float pulse = 0.0;
    //         float glow = 0.0;

    //         #ifdef DYN_LIGHT_FLICKER
    //             float time = frameTimeCounter / 3600.0;
    //             float flickerNoise = GetDynLightFlickerNoise(noiseSample);
    //         #endif

    //         switch (blockId) {
    //             case BLOCK_AMETHYST_CLUSTER:
    //                 glow = 0.2;
    //                 break;
    //             case BLOCK_BEACON:
    //                 break;
    //             case BLOCK_BLAST_FURNACE_LIT_N:
    //             case BLOCK_BLAST_FURNACE_LIT_E:
    //             case BLOCK_BLAST_FURNACE_LIT_S:
    //             case BLOCK_BLAST_FURNACE_LIT_W:
    //                 lightOffset = vec3(0.0, -0.4, 0.0);
    //                 break;
    //             case BLOCK_BREWING_STAND:
    //                 break;
    //             case BLOCK_CANDLES_LIT_1:
    //                 flicker = 0.14;
    //                 break;
    //             case BLOCK_CANDLES_LIT_2:
    //                 flicker = 0.14;
    //                 break;
    //             case BLOCK_CANDLES_LIT_3:
    //                 flicker = 0.14;
    //                 break;
    //             case BLOCK_CANDLES_LIT_4:
    //                 flicker = 0.14;
    //                 break;
    //             case BLOCK_CANDLE_CAKE_LIT:
    //                 lightOffset = vec3(0.0, 0.4, 0.0);
    //                 flicker = 0.14;
    //                 break;
    //             case BLOCK_CAVEVINE_BERRIES:
    //                 break;
    //             case BLOCK_CRYING_OBSIDIAN:
    //                 glow = 0.3;
    //                 break;
    //             case BLOCK_END_ROD:
    //                 break;
    //             case BLOCK_FIRE:
    //                 lightOffset = vec3(0.0, -0.3, 0.0);
    //                 flicker = 0.5;
    //                 break;
    //             case BLOCK_FURNACE_LIT_N:
    //             case BLOCK_FURNACE_LIT_E:
    //             case BLOCK_FURNACE_LIT_S:
    //             case BLOCK_FURNACE_LIT_W:
    //                 lightOffset = vec3(0.0, -0.2, 0.0);
    //                 break;
    //             case BLOCK_GLOWSTONE:
    //                 glow = 0.4;
    //                 break;
    //             case BLOCK_GLOW_LICHEN:
    //                 glow = 0.2;
    //                 break;
    //             case BLOCK_JACK_O_LANTERN_N:
    //                 lightOffset = vec3(0.0, 0.0, -0.4) * DynamicLightPenumbraF;
    //                 flicker = 0.3;
    //                 break;
    //             case BLOCK_JACK_O_LANTERN_E:
    //                 #if DYN_LIGHT_PENUMBRA > 0
    //                     lightOffset = vec3(0.4, 0.0, 0.0) * DynamicLightPenumbraF;
    //                 #endif
    //                 flicker = 0.3;
    //                 break;
    //             case BLOCK_JACK_O_LANTERN_S:
    //                 #if DYN_LIGHT_PENUMBRA > 0
    //                     lightOffset = vec3(0.0, 0.0, 0.4) * DynamicLightPenumbraF;
    //                 #endif
    //                 flicker = 0.3;
    //                 break;
    //             case BLOCK_JACK_O_LANTERN_W:
    //                 #if DYN_LIGHT_PENUMBRA > 0
    //                     lightOffset = vec3(-0.4, 0.0, 0.0) * DynamicLightPenumbraF;
    //                 #endif
    //                 flicker = 0.3;
    //                 break;
    //             case BLOCK_LANTERN:
    //                 lightOffset = vec3(0.0, -0.25, 0.0);
    //                 flicker = 0.05;
    //                 break;
    //             case BLOCK_LIGHTING_ROD_POWERED:
    //                 flicker = 0.8;
    //                 break;
    //             case BLOCK_AMETHYST_BUD_LARGE:
    //                 glow = 0.2;
    //                 break;
    //             case BLOCK_LAVA:
    //                 glow = 0.4;
    //                 break;
    //             case BLOCK_LAVA_CAULDRON:
    //                 #if DYN_LIGHT_PENUMBRA > 0
    //                     lightOffset = vec3(0.0, 0.4, 0.0);
    //                 #else
    //                     lightOffset = vec3(0.0, 0.2, 0.0);
    //                 #endif
    //                 glow = 0.4;
    //                 break;
    //             case BLOCK_MAGMA:
    //                 glow = 0.2;
    //                 break;
    //             case BLOCK_AMETHYST_BUD_MEDIUM:
    //                 glow = 0.2;
    //                 break;
    //             case BLOCK_NETHER_PORTAL:
    //                 glow = 0.8;
    //                 break;
    //             case BLOCK_FROGLIGHT_OCHRE:
    //                 glow = 0.2;
    //                 break;
    //             case BLOCK_FROGLIGHT_PEARLESCENT:
    //                 glow = 0.2;
    //                 break;
    //             case BLOCK_REDSTONE_LAMP_LIT:
    //                 break;
    //             case BLOCK_REDSTONE_TORCH_LIT:
    //                 break;
    //             case BLOCK_RESPAWN_ANCHOR_4:
    //                 lightOffset = vec3(0.0, 0.4, 0.0);
    //                 glow = 0.6;
    //                 break;
    //             case BLOCK_RESPAWN_ANCHOR_3:
    //                 lightOffset = vec3(0.0, 0.4, 0.0);
    //                 glow = 0.6;
    //                 break;
    //             case BLOCK_RESPAWN_ANCHOR_2:
    //                 lightOffset = vec3(0.0, 0.4, 0.0);
    //                 glow = 0.6;
    //                 break;
    //             case BLOCK_RESPAWN_ANCHOR_1:
    //                 lightOffset = vec3(0.0, 0.4, 0.0);
    //                 glow = 0.6;
    //                 break;
    //             case BLOCK_SCULK_CATALYST:
    //                 lightOffset = vec3(0.0, 0.4, 0.0);
    //                 break;
    //             case BLOCK_SEA_LANTERN:
    //                 glow = 0.4;
    //                 break;
    //             case BLOCK_SEA_PICKLE_WET_1:
    //             case BLOCK_SEA_PICKLE_WET_2:
    //             case BLOCK_SEA_PICKLE_WET_3:
    //             case BLOCK_SEA_PICKLE_WET_4:
    //                 glow = 0.9;
    //                 break;
    //             case BLOCK_SHROOMLIGHT:
    //                 glow = 0.6;
    //                 break;
    //             case BLOCK_SMOKER_LIT_N:
    //             case BLOCK_SMOKER_LIT_E:
    //             case BLOCK_SMOKER_LIT_S:
    //             case BLOCK_SMOKER_LIT_W:
    //                 lightOffset = vec3(0.0, -0.3, 0.0);
    //                 break;
    //             case BLOCK_SOUL_FIRE:
    //             case BLOCK_SOUL_LANTERN:
    //                 lightOffset = vec3(0.0, -0.25, 0.0);
    //                 flicker = 0.1;
    //                 break;
    //             case BLOCK_SOUL_TORCH:
    //                 flicker = 0.1;
    //                 break;
    //             case BLOCK_TORCH:
    //                 lightOffset = vec3(0.0, 0.4, 0.0);
    //                 flicker = 0.4;
    //                 break;
    //             case BLOCK_FROGLIGHT_VERDANT:
    //                 glow = 0.2;
    //                 break;
    //         }
            
    //         // if (blockId == BLOCK_TORCH) {
    //         //     //vec3 texPos = worldPos.xzy * vec3(0.04, 0.04, 0.02);
    //         //     //texPos.z += 2.0 * time;

    //         //     //vec2 s = texture(TEX_CLOUD_NOISE, texPos).rg;

    //         //     //lightOffset = 0.08 * hash44(vec4(worldPos * 0.04, 2.0 * time)).xyz - 0.04;
    //         //     //lightOffset = 0.12 * hash44(vec4(worldPos * 0.04, 4.0 * time)).xyz - 0.06;
    //         // }

    //         #ifdef DYN_LIGHT_FLICKER
    //             if (flicker > EPSILON) {
    //                 lightColorFinal.rgb *= 1.0 - flicker * (1.0 - flickerNoise);
    //             }

    //             if (glow > EPSILON) {
    //                 float cycle = sin(fract(time * 1000.0) * TAU) * 0.5 + 0.5;
    //                 lightColorFinal.rgb *= 1.0 - glow * smoothstep(0.0, 1.0, noiseSample.r);
    //             }
    //         #endif
    //     }

    //     if (lightRange > EPSILON) {
    //         atomicAdd(SceneLightMaxCount, 1u);

    //         #ifdef DYN_LIGHT_FRUSTUM_TEST
    //             vec3 lightViewPos = (gbufferModelView * vec4(blockLocalPos, 1.0)).xyz;
    //             bool intersects = true;

    //             float maxRange = lightRange > EPSILON ? lightRange : 16.0;
    //             if (lightViewPos.z > maxRange) intersects = false;
    //             else if (lightViewPos.z < -far - maxRange) intersects = false;
    //             else {
    //                 if (dot(sceneViewUp,   lightViewPos) > maxRange) intersects = false;
    //                 if (dot(sceneViewDown, lightViewPos) > maxRange) intersects = false;
    //                 if (dot(sceneViewLeft,  lightViewPos) > maxRange) intersects = false;
    //                 if (dot(sceneViewRight, lightViewPos) > maxRange) intersects = false;
    //             }

    //             if (!intersects) return;
    //         #endif

    //         float lightSize = GetSceneBlockLightSize(blockId);
    //         uint lightData = BuildBlockLightMask(blockId, lightSize);
    //         SceneLightData light = SceneLightData(blockLocalPos + lightOffset, lightRange, lightColorFinal, lightData);

    //         AddSceneLight(light);
    //     }
    //     #if DYN_LIGHT_MODE == DYN_LIGHT_TRACED
    //         else if (IsDynLightSolidBlock(blockId)) {
    //             ivec3 gridCell, blockCell;
    //             vec3 gridPos = GetLightGridPosition(blockLocalPos);
                
    //             if (GetSceneLightGridCell(gridPos, gridCell, blockCell)) {
    //                 uint gridIndex = GetSceneLightGridIndex(gridCell);
    //                 uint blockType = GetBlockType(blockId);
    //                 SetSceneBlockMask(blockCell, gridIndex, blockType);
    //             }
    //         }
    //     #endif
    // }

    // void AddSceneBlockLight(const in int blockId, const in vec3 blockLocalPos) {
    //     float lightRange = GetSceneBlockLightLevel(blockId);
    //     vec3 lightColor = vec3(0.0);

    //     if (lightRange > EPSILON) {
    //         vec2 noiseSample = vec2(0.0);
    //         #ifdef DYN_LIGHT_FLICKER
    //             noiseSample = GetDynLightNoise(cameraPosition + blockLocalPos);
    //         #endif

    //         lightColor = GetSceneBlockLightColor(blockId, noiseSample);
    //     }

    //     AddSceneBlockLight(blockId, blockLocalPos, lightColor, lightRange);
    // }
#endif