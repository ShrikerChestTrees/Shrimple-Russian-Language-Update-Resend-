const float phaseAir = phaseIso;

#ifdef WORLD_SKY_ENABLED
	float AirAmbientF = mix(0.008, 0.02, skyRainStrength);
	const float AirScatterRainF = 0.036;
	const float AirExtinctRainF = 0.009;

	float AirScatterF = mix(0.010, 0.028, skyRainStrength);
	float AirExtinctF = mix(0.002, 0.006, skyRainStrength);
#else
	vec3 tint = RGBToLinear(fogColor);// * 0.8 + 0.08;

	const vec3 AirAmbientF = tint * 4.0;

	float AirScatterF = 0.07;// * tint;
	float AirExtinctF = 0.02;
#endif
