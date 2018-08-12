// P_1_1_1_01
// Draw the color spectrum by moving the mouse.

#ifdef GL_ES
precision mediump float;
#endif

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

    // Calculate hue based on current horizontal pixel
    // and cursor position.
    float stepX = u_resolution.x / u_mouse.x;
    float hue = floor(stepX * st.x) / stepX;

    // Calculate hue based on current vertical pixel
    // and cursor position.
    float stepY = u_resolution.y / u_mouse.y;
    float sat = 1.0 - floor(stepY * st.y) / stepY;

    // Generate HSB color.
    vec3 color = hsb2rgb(vec3(
        hue,
        sat,
        1.0
    ));

    gl_FragColor = vec4(color, 1.0);
}
