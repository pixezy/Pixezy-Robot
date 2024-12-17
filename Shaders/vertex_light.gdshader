shader_type spatial;
render_mode vertex_lighting; 
uniform sampler2D _albedo:source_color; 

void fragment(){
	ALBEDO = texture(_albedo, UV).rgb; 
}