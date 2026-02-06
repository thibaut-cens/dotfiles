#version 300 es

// 1. Precision must come first in 300 es
precision mediump float;

// 2. Constants and Variables
const float dim = 0.4;

// Input from Hyprland's vertex shader
in vec2 v_texcoord;

// The screen texture passed by Hyprland
uniform sampler2D tex;

// Define output variable
out vec4 fragColor;

void main() {
    // texture() is the modern replacement for texture2D()
    vec4 pix = texture(tex, v_texcoord);

    // Apply the dimming constant to the RGB channels
    fragColor = vec4(pix.rgb * dim, pix.a);
}
