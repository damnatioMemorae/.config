#version 300 es

precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

const float PIXEL_COUNT = 350.0;
const float ASPECT_RATIO = 16.0 / 9.0;

void main() {
        vec2 pixelCount = vec2(PIXEL_COUNT * ASPECT_RATIO, PIXEL_COUNT);
        vec2 pixelSize = 1.0 / pixelCount;

        vec2 pixelCoord = floor(v_texcoord * pixelCount) + 0.5;
        vec2 sampleCoord = pixelCoord / pixelCount;

        fragColor = texture(tex, sampleCoord);
}
