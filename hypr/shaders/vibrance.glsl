#version 300 es

precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

const float RADIUS = 0.65;
const float SOFTNESS = 0.45;
const float STRENGTH = 0.5;
const float ASPECT_RATIO = 16.0 / 9.0;

void main() {
        vec4 color = texture(tex, v_texcoord);

        vec2 centered = v_texcoord - 0.5;
        centered.x *= ASPECT_RATIO;
        float dist = length(centered);
        dist /= length(vec2(ASPECT_RATIO * 0.5, 0.5));

        float innerEdge = RADIUS;
        float outerEdge = RADIUS + SOFTNESS;
        float vignette = 1.0 - smoothstep(innerEdge, outerEdge, dist);

        color.rgb = mix(color.rgb, color.rgb * vignette, STRENGTH);

        fragColor = color;
}
