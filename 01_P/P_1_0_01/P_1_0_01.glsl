// P_1_0_01
// Changing colors and size by moving the mouse.

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
    vec2 mousePos = u_mouse / u_resolution;

    // Set base color with a hue defined by the vertical
    // mouse position.
    vec3 color = hsb2rgb(vec3(mousePos.y, 1.0, 1.0));

    // Scale rectangle by horizontal mouse position.
    float rectScale = 0.5 - mousePos.x * 0.5;
    float isRect = 0.0;

    // Define bottom-left limit of rectangle.
    vec2 bottomLeft = step(vec2(rectScale), st);
    isRect = bottomLeft.x * bottomLeft.y;

    // Define top-right limit of rectangle.
    vec2 topRight = step(vec2(rectScale), 1.0 - st);
    isRect *= topRight.x * topRight.y;

    // If current position is within the rectangle space,
    // set color with an inverted hue from that of the
    // background color.
    if (isRect == 1.0) {
        color = hsb2rgb(vec3(1.0 - mousePos.y, 1.0, 1.0));
    }

    gl_FragColor = vec4(color, 1.0);
}
