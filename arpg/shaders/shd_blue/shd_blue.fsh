//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 original_color = texture2D( gm_BaseTexture, v_vTexcoord);
	vec4 output_color;
	
	if (original_color.a > 0.0)
		output_color = vec4(0.0, 0.0, original_color.b, 1.0);
	else
		output_color = original_color;

    gl_FragColor = output_color;
}
