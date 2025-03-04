shader_type canvas_item;
render_mode unshaded;
uniform vec4 color: hint_color;
uniform float player = 0;
uniform float white = 0;
void fragment(){
	 vec4 sprite_color = texture(TEXTURE, UV);
    float is_black = step(0.01, dot(sprite_color.rgb, vec3(1.0)));
    vec3 white_effect = vec3(0.57 * white);
    vec3 final_color = mix(color.rgb * player, sprite_color.rgb, is_black) + white_effect * white;
    COLOR = vec4(final_color, sprite_color.a);
}