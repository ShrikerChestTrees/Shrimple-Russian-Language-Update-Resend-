#define SHADOW_TYPE_NONE 0
//#define SHADOW_TYPE_BASIC 1
#define SHADOW_TYPE_DISTORTED 2
#define SHADOW_TYPE_CASCADED 3

#define SHADOW_COLOR_DISABLED 0
#define SHADOW_COLOR_ENABLED 1
#define SHADOW_COLOR_IGNORED 2

#define HAND_LIGHT_NONE 0
#define HAND_LIGHT_VERTEX 1
#define HAND_LIGHT_PIXEL 2

#define DYN_LIGHT_NONE 0
#define DYN_LIGHT_VERTEX 1
#define DYN_LIGHT_PIXEL 2


#define BUFFER_BLOCKLIGHT_PREV colortex5


#define BLOCKTYPE_EMPTY 0u
#define BLOCKTYPE_SOLID 1u
#define BLOCKTYPE_ANVIL_N_S 2u
#define BLOCKTYPE_ANVIL_W_E 3u
#define BLOCKTYPE_CACTUS 4u
#define BLOCKTYPE_CAKE 5u
#define BLOCKTYPE_CANDLE_CAKE 6u
#define BLOCKTYPE_CARPET 7u
#define BLOCKTYPE_DAYLIGHT_DETECTOR 8u
#define BLOCKTYPE_ENCHANTING_TABLE 9u
#define BLOCKTYPE_END_PORTAL_FRAME 10u
#define BLOCKTYPE_FLOWER_POT 11u
#define BLOCKTYPE_GRINDSTONE_FLOOR_N_S 12u
#define BLOCKTYPE_GRINDSTONE_FLOOR_W_E 13u
#define BLOCKTYPE_GRINDSTONE_WALL_N_S 14u
#define BLOCKTYPE_GRINDSTONE_WALL_W_E 15u
#define BLOCKTYPE_HOPPER_DOWN 16u
#define BLOCKTYPE_HOPPER_N 17u
#define BLOCKTYPE_HOPPER_E 18u
#define BLOCKTYPE_HOPPER_S 19u
#define BLOCKTYPE_HOPPER_W 20u
#define BLOCKTYPE_LECTERN 21u
#define BLOCKTYPE_PATHWAY 22u
#define BLOCKTYPE_PRESSURE_PLATE 23u
#define BLOCKTYPE_STONECUTTER 24u

#define BLOCKTYPE_BUTTON_FLOOR_N_S 30u
#define BLOCKTYPE_BUTTON_FLOOR_W_E 31u
#define BLOCKTYPE_BUTTON_CEILING_N_S 32u
#define BLOCKTYPE_BUTTON_CEILING_W_E 33u
#define BLOCKTYPE_BUTTON_WALL_N 34u
#define BLOCKTYPE_BUTTON_WALL_E 35u
#define BLOCKTYPE_BUTTON_WALL_S 36u
#define BLOCKTYPE_BUTTON_WALL_W 37u

#define BLOCKTYPE_DOOR_N 38u
#define BLOCKTYPE_DOOR_E 39u
#define BLOCKTYPE_DOOR_S 40u
#define BLOCKTYPE_DOOR_W 41u

#define BLOCKTYPE_LEVER_FLOOR_N_S 42u
#define BLOCKTYPE_LEVER_FLOOR_W_E 43u
#define BLOCKTYPE_LEVER_CEILING_N_S 44u
#define BLOCKTYPE_LEVER_CEILING_W_E 45u
#define BLOCKTYPE_LEVER_WALL_N 46u
#define BLOCKTYPE_LEVER_WALL_E 47u
#define BLOCKTYPE_LEVER_WALL_S 48u
#define BLOCKTYPE_LEVER_WALL_W 49u

#define BLOCKTYPE_TRAPDOOR_BOTTOM 50u
#define BLOCKTYPE_TRAPDOOR_TOP 51u
#define BLOCKTYPE_TRAPDOOR_N 52u
#define BLOCKTYPE_TRAPDOOR_E 53u
#define BLOCKTYPE_TRAPDOOR_S 54u
#define BLOCKTYPE_TRAPDOOR_W 55u

#define BLOCKTYPE_TRIPWIRE_HOOK_N 56u
#define BLOCKTYPE_TRIPWIRE_HOOK_E 57u
#define BLOCKTYPE_TRIPWIRE_HOOK_S 58u
#define BLOCKTYPE_TRIPWIRE_HOOK_W 59u

#define BLOCKTYPE_SLAB_TOP 60u
#define BLOCKTYPE_SLAB_BOTTOM 61u

#define BLOCKTYPE_STAIRS_BOTTOM_N 62u
#define BLOCKTYPE_STAIRS_BOTTOM_E 63u
#define BLOCKTYPE_STAIRS_BOTTOM_S 64u
#define BLOCKTYPE_STAIRS_BOTTOM_W 65u
#define BLOCKTYPE_STAIRS_BOTTOM_INNER_N_W 66u
#define BLOCKTYPE_STAIRS_BOTTOM_INNER_N_E 67u
#define BLOCKTYPE_STAIRS_BOTTOM_INNER_S_W 68u
#define BLOCKTYPE_STAIRS_BOTTOM_INNER_S_E 69u
#define BLOCKTYPE_STAIRS_BOTTOM_OUTER_N_W 70u
#define BLOCKTYPE_STAIRS_BOTTOM_OUTER_N_E 71u
#define BLOCKTYPE_STAIRS_BOTTOM_OUTER_S_W 72u
#define BLOCKTYPE_STAIRS_BOTTOM_OUTER_S_E 73u
#define BLOCKTYPE_STAIRS_TOP_N 74u
#define BLOCKTYPE_STAIRS_TOP_E 75u
#define BLOCKTYPE_STAIRS_TOP_S 76u
#define BLOCKTYPE_STAIRS_TOP_W 77u
#define BLOCKTYPE_STAIRS_TOP_INNER_N_W 78u
#define BLOCKTYPE_STAIRS_TOP_INNER_N_E 79u
#define BLOCKTYPE_STAIRS_TOP_INNER_S_W 80u
#define BLOCKTYPE_STAIRS_TOP_INNER_S_E 81u
#define BLOCKTYPE_STAIRS_TOP_OUTER_N_W 82u
#define BLOCKTYPE_STAIRS_TOP_OUTER_N_E 83u
#define BLOCKTYPE_STAIRS_TOP_OUTER_S_W 84u
#define BLOCKTYPE_STAIRS_TOP_OUTER_S_E 85u

#define BLOCKTYPE_FENCE_POST 86u
#define BLOCKTYPE_FENCE_N 87u
#define BLOCKTYPE_FENCE_E 88u
#define BLOCKTYPE_FENCE_S 89u
#define BLOCKTYPE_FENCE_W 90u
#define BLOCKTYPE_FENCE_N_S 91u
#define BLOCKTYPE_FENCE_W_E 92u
#define BLOCKTYPE_FENCE_N_W 93u
#define BLOCKTYPE_FENCE_N_E 94u
#define BLOCKTYPE_FENCE_S_W 95u
#define BLOCKTYPE_FENCE_S_E 96u
#define BLOCKTYPE_FENCE_W_N_E 97u
#define BLOCKTYPE_FENCE_W_S_E 98u
#define BLOCKTYPE_FENCE_N_W_S 99u
#define BLOCKTYPE_FENCE_N_E_S 100u
#define BLOCKTYPE_FENCE_ALL 101u

#define BLOCKTYPE_FENCE_GATE_CLOSED_N_S 102u
#define BLOCKTYPE_FENCE_GATE_CLOSED_W_E 103u

#define BLOCKTYPE_WALL_POST 104u
#define BLOCKTYPE_WALL_POST_LOW_N 105u
#define BLOCKTYPE_WALL_POST_LOW_E 106u
#define BLOCKTYPE_WALL_POST_LOW_S 107u
#define BLOCKTYPE_WALL_POST_LOW_W 108u
#define BLOCKTYPE_WALL_POST_LOW_N_S 109u
#define BLOCKTYPE_WALL_POST_LOW_W_E 110u
#define BLOCKTYPE_WALL_POST_LOW_N_W 111u
#define BLOCKTYPE_WALL_POST_LOW_N_E 112u
#define BLOCKTYPE_WALL_POST_LOW_S_W 113u
#define BLOCKTYPE_WALL_POST_LOW_S_E 114u
#define BLOCKTYPE_WALL_POST_LOW_N_W_S 115u
#define BLOCKTYPE_WALL_POST_LOW_N_E_S 116u
#define BLOCKTYPE_WALL_POST_LOW_W_N_E 117u
#define BLOCKTYPE_WALL_POST_LOW_W_S_E 118u
#define BLOCKTYPE_WALL_POST_LOW_ALL 119u
#define BLOCKTYPE_WALL_POST_TALL_N 120u
#define BLOCKTYPE_WALL_POST_TALL_E 121u
#define BLOCKTYPE_WALL_POST_TALL_S 122u
#define BLOCKTYPE_WALL_POST_TALL_W 123u
#define BLOCKTYPE_WALL_POST_TALL_N_S 124u
#define BLOCKTYPE_WALL_POST_TALL_W_E 125u
#define BLOCKTYPE_WALL_POST_TALL_N_W 126u
#define BLOCKTYPE_WALL_POST_TALL_N_E 127u
#define BLOCKTYPE_WALL_POST_TALL_S_W 128u
#define BLOCKTYPE_WALL_POST_TALL_S_E 129u
#define BLOCKTYPE_WALL_POST_TALL_N_W_S 130u
#define BLOCKTYPE_WALL_POST_TALL_N_E_S 131u
#define BLOCKTYPE_WALL_POST_TALL_W_N_E 132u
#define BLOCKTYPE_WALL_POST_TALL_W_S_E 133u
#define BLOCKTYPE_WALL_POST_TALL_ALL 134u
#define BLOCKTYPE_WALL_LOW_N_S 135u
#define BLOCKTYPE_WALL_LOW_W_E 136u
#define BLOCKTYPE_WALL_TALL_N_S 137u
#define BLOCKTYPE_WALL_TALL_W_E 138u

#define BLOCKTYPE_CHORUS_DOWN 139u
#define BLOCKTYPE_CHORUS_UP_DOWN 140u
#define BLOCKTYPE_CHORUS_OTHER 141u

#define BLOCKTYPE_STAINED_GLASS_BLACK 142u
#define BLOCKTYPE_STAINED_GLASS_BLUE 143u
#define BLOCKTYPE_STAINED_GLASS_BROWN 144u
#define BLOCKTYPE_STAINED_GLASS_CYAN 145u
#define BLOCKTYPE_STAINED_GLASS_GRAY 146u
#define BLOCKTYPE_STAINED_GLASS_GREEN 147u
#define BLOCKTYPE_STAINED_GLASS_LIGHT_BLUE 148u
#define BLOCKTYPE_STAINED_GLASS_LIGHT_GRAY 149u
#define BLOCKTYPE_STAINED_GLASS_LIME 150u
#define BLOCKTYPE_STAINED_GLASS_MAGENTA 151u
#define BLOCKTYPE_STAINED_GLASS_ORANGE 152u
#define BLOCKTYPE_STAINED_GLASS_PINK 153u
#define BLOCKTYPE_STAINED_GLASS_PURPLE 154u
#define BLOCKTYPE_STAINED_GLASS_RED 155u
#define BLOCKTYPE_STAINED_GLASS_WHITE 156u
#define BLOCKTYPE_STAINED_GLASS_YELLOW 157u

#define BLOCKTYPE_LIGHT 255u

#define TEX_LIGHT_NOISE noisetex
