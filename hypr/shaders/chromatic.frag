#version 300 es

precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

const float STRENGTH = 0.010;
const float ASPECT_RATIO = 16.0 / 9.0;
const bool QUADRATIC_FALLOFF = true;

void main() {
        vec2 distFromCenter = v_texcoord - 0.5;
        distFromCenter.x *= ASPECT_RATIO;

        float dist = length(distFromCenter);
        float falloff = QUADRATIC_FALLOFF ? dist * dist : dist;

        vec2 dir = normalize(distFromCenter + 0.0001);
        vec2 offset = dir * falloff * STRENGTH;
        offset.x /= ASPECT_RATIO;

        vec2 redCoord = clamp(v_texcoord - offset, 0.0, 1.0);
        vec2 blueCoord = clamp(v_texcoord + offset, 0.0, 1.0);

        float r = texture(tex, redCoord).r;
        vec4 centerPixel = texture(tex, v_texcoord);
        float g = centerPixel.g;
        float b = texture(tex, blueCoord).b;

        fragColor = vec4(r, g, b, centerPixel.a);
}
