#version 150

#define HOVER_Z 0
#define BOUND_Y_UPPER 0.8
#define BOUND_Y_LOWER -0.8

in vec3 Position;
in vec4 Color;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec4 vertexColor;
out float modify;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    vec4 position = gl_Position;
    modify = 0.0;
    if ((position.z == HOVER_Z) &&
        (position.y > BOUND_Y_LOWER && position.y < BOUND_Y_UPPER)) {
        modify = 1.0;
    }
    vertexColor = Color;
}
