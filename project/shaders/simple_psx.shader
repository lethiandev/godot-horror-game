shader_type spatial;
render_mode depth_draw_opaque, cull_disabled, skip_vertex_transform;

uniform sampler2D albedo_texture;
uniform float roughness = 1.0;
uniform float metallic = 0.0;
uniform float specular = 0.0;

vec4 fake_psx_vertex(vec4 vertex, vec2 resolution) {
	vec4 snapped = vertex;
	snapped.xyz = vertex.xyz / vertex.w;
	snapped.xy = floor(resolution * snapped.xy) / resolution;
	snapped.xyz = snapped.xyz * vertex.w;
		
	return snapped;
}

void vertex() {
	POSITION = (PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0));
	POSITION = fake_psx_vertex(POSITION, VIEWPORT_SIZE.xy * 0.25);
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	NORMAL = (MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
}

void fragment() {
	ALBEDO = texture(albedo_texture, UV).rgb;
	ROUGHNESS = roughness;
	METALLIC = metallic;
	SPECULAR = specular;
}
