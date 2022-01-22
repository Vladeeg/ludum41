package openfl8;

import flixel.system.FlxAssets.FlxShader;
import openfl.display.BitmapData;

/**
 * A classic mosaic effect, just like in the old days!
 *
 * Usage notes:
 * - The effect will be applied to the whole screen.
 * - Set the x/y-values on the 'uBlocksize' vector to the desired size (setting this to 0 will make the screen go black)
 */
class LightingShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header
		uniform vec2 frameCoords;
		uniform sampler2D normalMap;
		uniform sampler2D specularMap;
		uniform vec2 worldPos;

		uniform vec3 lightPos;
		uniform vec3 lightColor;
		uniform float lightRadius;

		uniform vec2 frameSize;

		void main()
		{
			vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
			vec4 specular = flixel_texture2D(specularMap, openfl_TextureCoordv);
			vec3 normal = 2.0 * flixel_texture2D(normalMap, openfl_TextureCoordv).xyz - 1.0;
			normal.y = -normal.y;

			vec2 pixel_coords = worldPos + ((openfl_TextureCoordv - frameCoords) * frameSize);
			vec3 light_direction = lightPos - vec3(pixel_coords, 0);
			float distance = length(light_direction);
			light_direction = normalize(light_direction);

			// float attenuation = 5000.0/(distance * distance);

			// float diffuse_term = clamp(attenuation * dot(normal, light_direction), 0.0, 1.0);

			
			float diffuse = max(dot(normal, light_direction), 0.0);
			float distanceFactor = (1.0 - distance / lightRadius);

			// the shaded cel has a light value of 0.5, the light cel has a light value of 1
			float cel_diffuse_term = smoothstep(0.49, 0.52, diffuse) / 2.0 + 0.5;

			vec3 shadowColor = vec3(1.0) - lightColor;
			vec3 ambient = mix(shadowColor, lightColor, diffuse) * 0.20;

			if (color == vec4(0.0, 0.0, 0.0, 1.0)) {
				gl_FragColor = color;
			} else {
				gl_FragColor = color * cel_diffuse_term * distanceFactor + vec4(ambient, 1.0) * specular;
			}

			// gl_FragColor = vec4(cel_diffuse_term * color.rgb + ambient, color.a) * specular;
		}')
	public function new()
	{
		super();
	}
}
