#version 330 core
out vec4 FragColor;

uniform float uTime;

void main() {
    // Smooth oscillation between 0.2 and 1.0 brightness
    float glow = 0.6 + 0.4 * sin(uTime * 3.0);

    // Base orange color multiplied by glow intensity
    vec3 baseColor = vec3(1.0, 0.5, 0.2);
    vec3 finalColor = baseColor * glow;

    FragColor = vec4(finalColor, 1.0);
}
