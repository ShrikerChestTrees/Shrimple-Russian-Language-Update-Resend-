#define RENDER_SHADOW
#define RENDER_FRAG

#include "/lib/constants.glsl"
#include "/lib/common.glsl"

in vec2 gTexcoord;
in vec4 gColor;

#if SHADOW_TYPE == SHADOW_TYPE_CASCADED
	flat in vec2 gShadowTilePos;
#endif

uniform sampler2D gtexture;

uniform int renderStage;

#if MC_VERSION >= 11700
	uniform float alphaTestRef;
#endif


/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 outColor0;

void main() {
	#if SHADOW_TYPE == SHADOW_TYPE_CASCADED
		vec2 p = gl_FragCoord.xy / shadowMapSize - gShadowTilePos;
		if (clamp(p, vec2(0.0), vec2(0.5)) != p) discard;
	#endif

	vec4 color = texture(gtexture, gTexcoord);

	#if SHADOW_COLORS == SHADOW_COLOR_IGNORED
		if (renderStage == MC_RENDER_STAGE_TERRAIN_TRANSLUCENT && color.a < 0.9) {
			discard;
			return;
		}
	#endif
	
	if (renderStage != MC_RENDER_STAGE_TERRAIN_TRANSLUCENT) {
		if (color.a < alphaTestRef) {
			discard;
			return;
		}
	}

	color.rgb *= gColor.rgb;

	#ifdef SHADOW_COLOR_BLEND
		color.rgb = RGBToLinear(color.rgb);

		color.rgb = mix(color.rgb, vec3(1.0), _pow2(color.a));

		color.rgb = LinearToRGB(color.rgb);
	#endif

	outColor0 = color;
}
