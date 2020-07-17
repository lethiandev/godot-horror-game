shader_type spatial;
render_mode depth_draw_never, shadows_disabled;

uniform vec4 color = vec4(1.0, 1.0, 1.0, 0.5);

void fragment() {
	EMISSION = color.rgb;
	ALPHA = color.a;
	
	// Distance fade closer to camera
	ALPHA *= smoothstep(0.1, 1.2, -VERTEX.z);
	
	// Fade on shape edges
	float angle = dot(normalize(VIEW), NORMAL);
	ALPHA *= angle * angle;
	
	// Depth based distance fade
	float depth = textureLod(DEPTH_TEXTURE, SCREEN_UV, 0.0).r;
	vec4 ndc = vec4(SCREEN_UV * 2.0 - 1.0, depth * 2.0 - 1.0, 1.0);
	vec4 upos = INV_PROJECTION_MATRIX * ndc;
	
	float dist = VERTEX.z - (upos.z / upos.w);
	ALPHA *= smoothstep(0.0, 0.5, dist);
}
