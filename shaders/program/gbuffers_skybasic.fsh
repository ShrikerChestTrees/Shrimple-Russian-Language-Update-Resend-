#define RENDER_SKYBASIC
#define RENDER_GBUFFER
#define RENDER_FRAG

#include "/lib/common.glsl"
#include "/lib/constants.glsl"

varying vec4 starData; //rgb = star color, a = flag for weather or not this pixel is a star.

uniform mat4 gbufferModelView;
uniform mat4 gbufferProjectionInverse;
uniform float viewHeight;
uniform float viewWidth;
uniform vec3 fogColor;
uniform vec3 skyColor;

uniform float blindness;

#include "/lib/sampling/bayer.glsl"
#include "/lib/world/fog.glsl"
#include "/lib/post/tonemap.glsl"


/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 outColor0;

void main() {
	vec3 color;
	if (starData.a > 0.5) {
		color = starData.rgb;
	}
	else {
		vec3 pos = vec3(gl_FragCoord.xy / vec2(viewWidth, viewHeight) * 2.0 - 1.0, 1.0);
		pos = (gbufferProjectionInverse * vec4(pos, 1.0)).xyz;
		color = GetFogColor(normalize(pos.xyz));
	}

	color *= 1.0 - blindness;

    ApplyPostProcessing(color);
	outColor0 = vec4(color, 1.0);
}
