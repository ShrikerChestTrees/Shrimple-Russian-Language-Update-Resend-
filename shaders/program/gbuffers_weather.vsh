#define RENDER_WEATHER
#define RENDER_GBUFFER
#define RENDER_VERTEX

#define RENDER_BILLBOARD

#include "/lib/constants.glsl"
#include "/lib/common.glsl"

out vec2 texcoord;
out vec2 lmcoord;
out vec4 glcolor;
out float geoNoL;
out vec3 vPos;
out float vLit;
out vec3 vLocalPos;
out vec3 vBlockLight;

#ifdef WORLD_SHADOW_ENABLED
	#if SHADOW_TYPE == SHADOW_TYPE_CASCADED
		out vec3 shadowPos[4];
		flat out int shadowTile;
	#elif SHADOW_TYPE != SHADOW_TYPE_NONE
		out vec3 shadowPos;
	#endif
#endif

uniform sampler2D lightmap;
uniform sampler2D noisetex;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform float frameTimeCounter;
uniform vec3 cameraPosition;

#ifdef WORLD_SHADOW_ENABLED
	uniform mat4 shadowModelView;
	uniform mat4 shadowProjection;
	uniform vec3 shadowLightPosition;
	uniform float far;

	#if SHADOW_TYPE == SHADOW_TYPE_CASCADED
		uniform mat4 gbufferProjection;
		uniform float near;
	#endif
#endif

// #if defined IRIS_FEATURE_SSBO && DYN_LIGHT_MODE == DYN_LIGHT_VERTEX
//     uniform int heldItemId;
//     uniform int heldItemId2;
//     uniform int heldBlockLightValue;
//     uniform int heldBlockLightValue2;
//     uniform bool firstPersonCamera;
//     uniform vec3 eyePosition;
// #endif

#include "/lib/blocks.glsl"
#include "/lib/sampling/noise.glsl"

#ifdef WORLD_SHADOW_ENABLED
    #include "/lib/matrix.glsl"
    #include "/lib/buffers/shadow.glsl"

	#if SHADOW_TYPE == SHADOW_TYPE_CASCADED
		#include "/lib/shadows/cascaded.glsl"
	#elif SHADOW_TYPE != SHADOW_TYPE_NONE
		#include "/lib/shadows/basic.glsl"
	#endif
#endif

// #ifdef IRIS_FEATURE_SSBO
// 	#if DYN_LIGHT_MODE != DYN_LIGHT_NONE
// 		#include "/lib/items.glsl"
// 		#include "/lib/lighting/blackbody.glsl"
// 	#endif

// 	// #if DYN_LIGHT_MODE == DYN_LIGHT_VERTEX
// 	// 	#include "/lib/buffers/lighting.glsl"
// 	// 	#include "/lib/lighting/dynamic.glsl"
// 	// #endif

// 	#if DYN_LIGHT_MODE != DYN_LIGHT_NONE
// 		#include "/lib/lighting/dynamic_blocks.glsl"
// 	#endif
// #endif

#include "/lib/lighting/basic.glsl"


void main() {
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;

	//gl_Position = ftransform();
	BasicVertex();
}
