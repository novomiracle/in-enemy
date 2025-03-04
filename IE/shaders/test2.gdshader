shader_type canvas_item;
render_mode unshaded;
uniform vec4 color : hint_color;
void fragment(){
	vec4 sprite_color = texture(TEXTURE,UV);
	//COLOR = vec4(vec3(sprite_color.r,sprite_color.g,sprite_color.b)+color.rgb -  ceil(vec3(sprite_color.r,sprite_color.g,sprite_color.b))* color.rgb,sprite_color.a);
	float is_black = step(0.01, sprite_color.r + sprite_color.g + sprite_color.b);
    COLOR = vec4(mix(color.rgb, sprite_color.rgb, is_black), sprite_color.a);
}