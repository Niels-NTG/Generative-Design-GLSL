// P_1_1_2_01
// Change the color circle by moving the mouse.

#ifdef GL_ES
precision mediump float;
#endif

#define TAU 6.28318530718

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// HSB to RGB
vec3 hsb2rgb(in vec3 c) {
    vec3 rgb = clamp(abs(mod(c.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    rgb = rgb * rgb * (3.0 - 2.0 * rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

void main() {
    // Scale coordinates from 0.0 till 1.0
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec2 mousePos = u_mouse / u_resolution;

    // Calculate hue as an angle from the center between
    // 0 radians and TAU radians.
    vec2 toCenter = vec2(0.5) - st;
    float angle = atan(toCenter.y, toCenter.x);
    float hue = angle / TAU;

    // Calculate saturation based on current horizontal
    // cursor position.
    float sat = mousePos.x;

    // Calculate brightness based on current vertical
    // cursor position.
    float bri = mousePos.y;

    // Generate HSB color.
    vec3 color = hsb2rgb(vec3(
        hue,
        sat,
        bri
    ));

    // Add circle mask.
    color -= vec3(step(0.5, length(toCenter)));

    gl_FragColor = vec4(color, 1.0);
}
