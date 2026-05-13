#version 300 es

precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

const float SEPARATION = 0.003;
const bool DEPTH_AWARE = true;

void main() {
        vec2 offset = vec2(SEPARATION, 0.0);

        if (DEPTH_AWARE) {
                float edgeFactor = abs(v_texcoord.x - 0.5) * 2.0;
                offset.x *= 1.0 + edgeFactor * 0.5;
        }

        vec2 leftCoord = clamp(v_texcoord - offset, 0.0, 1.0);
        vec2 rightCoord = clamp(v_texcoord + offset, 0.0, 1.0);

        vec4 leftEye = texture(tex, leftCoord);
        vec4 rightEye = texture(tex, rightCoord);
        vec4 center = texture(tex, v_texcoord);

        fragColor = vec4(leftEye.r, rightEye.g, rightEye.b, center.a);
}
