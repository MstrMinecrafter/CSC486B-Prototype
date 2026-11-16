shader_type canvas_item;

uniform vec4 add_colour : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
	// COLOR already contains the sampled texture * modulate
	COLOR.rgb = clamp(COLOR.rgb + add_colour.rgb, 0.0, 1.0);
}