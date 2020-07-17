shader_type canvas_item;
render_mode unshaded, blend_disabled;

const mat4 invX = mat4(
		vec4(-0.5,  1.0,  -0.5, 0.0),
		vec4( 1.5, -2.5,   0.0, 1.0),
		vec4(-1.5,  2.0,   0.5, 0.0),
		vec4( 0.5, -0.5,   0.0, 0.0));

vec4 gamma_out(vec4 color) {
	return pow(color, vec4(1.0 / 2.222));
}

vec4 crt_hyllian_fast(sampler2D source, vec2 uv, vec2 pixel) {
	vec2 dx = vec2(pixel.x, 0.0);
	vec2 dy = vec2(0.0, pixel.y);
	
	vec2 texsize = (1.0 / pixel) * vec2(1.0, 1.333333);
	vec2 uvtexel = (floor(uv * texsize) + vec2(0.5)) / texsize;
	vec2 fp = fract(uv * texsize);
	
	vec4 c10 = textureLod(source, uvtexel - dx, 1.0);
	vec4 c11 = textureLod(source, uvtexel, 1.0);
	vec4 c12 = textureLod(source, uvtexel + dx, 1.0);
	vec4 c13 = textureLod(source, uvtexel + 2.0 * dx, 1.0);
	
	mat4 color_matrix = mat4(c10, c11, c12, c13);
	vec4 invX_Px = invX * vec4(fp.x*fp.x*fp.x, fp.x*fp.x, fp.x, 1.0);
	vec4 color = invX_Px * color_matrix;
	
	float d = smoothstep(0.0, 1.0, 1.0 - abs(fp.y - 0.5));
	
	return color * d;
}

void fragment() {
	COLOR = crt_hyllian_fast(SCREEN_TEXTURE, SCREEN_UV, SCREEN_PIXEL_SIZE);
}
