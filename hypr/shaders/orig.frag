precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

uniform mediump float time;

const float display_framerate = 60.0;
const vec2 display_resolution = vec2(2256.0, 1504.0);

vec2 curve(vec2 uv)
{
	uv = (uv - 0.5) * 2.0;
	uv *= 1.1;
	uv.x *= 1.0 + pow((abs(uv.y) / 8.0), 2.0);
	uv.y *= 1.0 + pow((abs(uv.x) / 8.0), 2.0);
	uv = (uv / 2.0) + 0.5;
	uv = uv * 0.92 + 0.04;
	return uv;
}

float rand(vec2 uv, float t)
{
	return fract(sin(dot(uv, vec2(1225.6548, 321.8942))) * 4251.4865 + t);
}

void main()
{
	vec2 uv = v_texcoord;
	uv = curve(uv);
	vec4 pixColor = texture2D(tex, uv);

	vec3 col = pixColor.rgb;

	float analog_noise = fract(sin(time) * 43758.5453123 * uv.y) * 0.0006;
	col.r = texture2D(tex, vec2(analog_noise + uv.x + 0.0008, uv.y + 0.0))
			.x +
		0.05;
	col.g = texture2D(tex,
			  vec2(analog_noise + uv.x + 0.0008, uv.y + 0.0005))
			.y +
		0.05;
	col.b = texture2D(tex, vec2(analog_noise + uv.x - 0.0008, uv.y + 0.0))
			.z +
		0.05;

	///////////////////////////////////////////////////////////////////////////////////////////////

	// Contrast
	col = mix(col, col * smoothstep(0.0, 1.0, col), 1.);
	col = mix(col, col * smoothstep(0.0, 1.0, col), 0.5);
	/////////////

	// Grain
	float scale = 2.8;
	float amount = 0.15;
	vec2 offset = (rand(uv, time) - 0.9) * 1.8 * uv * scale;
	vec3 noise = texture2D(tex, uv + offset).rgb;
	col.rgb = mix(col.rgb, noise, amount);
	////////////////////////////////
	col *= 12.8;
	/////

	///////////////////////////////////////////////////////////////////////////////////////////////

	// BLOOM
	const float blur_directions = 24.0;
	const float blur_quality = 4.0;
	const float blur_size = 12.0;
	const float blur_brightness = 6.5;

	const vec2 blur_radius = blur_size / (display_resolution.xy * 0.5);

	vec3 bloomColor = vec3(0.0);
	for (float d = 0.0; d < 6.283185307180;
	     d += 6.283185307180 / blur_directions) {
		for (float i = 1.0 / blur_quality; i <= 1.0;
		     i += 1.0 / blur_quality) {
			vec3 toAdd =
				texture2D(tex, uv + vec2(cos(d), sin(d)) *
							       blur_radius * i)
					.rgb;
			toAdd *= blur_brightness * vec3(1.5, 0.85, 0.40);
			bloomColor += toAdd;
		}
	}

	bloomColor /= blur_quality * blur_directions;

	col.rgb += bloomColor;
	////////////////////////////////////////////////////////////////////////////////////////

	///////////////////////////////////////////////////////////////////////////////////////////////

	// SCANLINES
	float scanvar = 0.3;
	float scanlines =
		clamp(scanvar + scanvar * sin(display_framerate * 1.95 *
						      mod(-time, 8.0) +
					      uv.y * display_resolution.y),
		      0.0, 1.0);

	float s = pow(scanlines, 1.7);
	col = col * vec3(0.4 + 0.7 * s);
	///////////////////////////////////////////////////////////////////////////////////////////////

	// FLICKER
	float flickerAmount = 0.10;
	col *= 1.0 + flickerAmount * sin(display_framerate * 2.0 * time);
	///////////////////////////////////////////////////////////////////////////////////////////////

	if (uv.x < 0.0 || uv.x > 1.0)
		col *= 0.0;
	if (uv.y < 0.0 || uv.y > 1.0)
		col *= 0.0;

	float phosphor = 0.0;
	float rPhosphor =
		clamp(phosphor + phosphor * sin((uv.x) * display_resolution.x *
						1.333333333),
		      0.0, 1.0);
	float gPhosphor = clamp(phosphor + phosphor * sin((uv.x + 0.333333333) *
							  display_resolution.x *
							  1.333333333),
				0.0, 1.0);
	float bPhosphor = clamp(phosphor + phosphor * sin((uv.x + 0.666666666) *
							  display_resolution.x *
							  1.333333333),
				0.0, 1.0);

	col.r -= rPhosphor;
	col.g -= gPhosphor;
	col.b -= bPhosphor;

	col *= 0.5;
	///////////////////////////////////////////////////////////////////////////////////////////////
	// VIGNETTE FROM CURVATURE
	const float vignetteStrenght = 200.;
	const float vignetteExtend = 0.5;

	vec2 uv_ = uv * (1.0 - uv.yx);
	float vignette = uv_.x * uv_.y * vignetteStrenght;
	vignette = clamp(pow(vignette, vignetteExtend), 0., 1.0);

	col *= vec3(vignette);
	///////////////////////////////////////////////////////////////////////////////////////////////

	// CRUDE COLOR GAMUT REDUCTION
	pixColor.r = mix(col.r, mix(col.g, col.b, 0.9), 0.05);
	pixColor.g = mix(col.g, mix(col.r, col.b, 0.3), 0.05);
	pixColor.b = mix(col.b, mix(col.g, col.r, 0.8), 0.05);

	pixColor.rb *= vec2(1.04, 0.8);

	// gl_FragColor = pixColor;

	gl_FragColor = vec4(col, 1.);
}
