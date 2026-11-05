shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 col = vec3(0);
	float crth = min(sin(SCREEN_UV.y * 256.0 + TIME * 2.0 + sin(TIME*78.)*.15) + 1.0, 1.1);
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	col += screen_color.rgb * crth;
    
    // Example Effect: Invert the whole screen's colors
    //vec3 inverted_rgb = vec3(1.0) - screen_color.rgb;
	COLOR = vec4(col, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
