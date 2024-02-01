#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in float modify;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) {discard;}

    // dont even ask why this is here -Floop
    // if (modify == 1.0) {/*discard;*/}

    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}