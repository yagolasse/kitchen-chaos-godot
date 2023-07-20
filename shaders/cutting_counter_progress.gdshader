shader_type spatial;

uniform float percentage_complete: hint_range(0.0, 1.0, 0.1);
uniform vec4 background_color: source_color;

void fragment() {
	if (UV.x < percentage_complete) {
		ALBEDO = COLOR.rgb;
		ALPHA = COLOR.a;
	} else {
		ALBEDO = background_color.rgb;
		ALPHA = background_color.a;
	}
}
