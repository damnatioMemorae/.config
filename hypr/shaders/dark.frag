precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);

    pixColor[0] *= 0.8; // red
    pixColor[1] *= 0.7; // green
    pixColor[2] *= 0.6; // blue

    gl_FragColor = pixColor;
}
