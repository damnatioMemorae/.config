#version 300 es

precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

const float COLOR_LEVELS = 4.0;
const bool DITHER = true;

float dither(vec2 pos) {
        vec2 p = fract(pos * 0.5);
        float d = fract(dot(p, vec2(0.75, 0.5)));
        return (d - 0.5) / COLOR_LEVELS;
}

void main() {
        vec4 color = texture(tex, v_texcoord);

        vec3 posterized;
        if (DITHER) {
                float ditherValue = dither(gl_FragCoord.xy);
                posterized = floor((color.rgb + ditherValue) * COLOR_LEVELS + 0.5) / COLOR_LEVELS;
        } else {
                posterized = floor(color.rgb * COLOR_LEVELS + 0.5) / COLOR_LEVELS;
        }

        posterized = clamp(posterized, 0.0, 1.0);
        fragColor = vec4(posterized, color.a);
}
