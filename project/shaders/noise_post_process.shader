shader_type canvas_item;

float random(vec2 n) { 
	return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

void fragment() {
	float factor = floor(TIME * 12.0) / 12.0;
	COLOR = vec4(1.0, 1.0, 1.0, random(SCREEN_UV * factor) * 0.05);
}
