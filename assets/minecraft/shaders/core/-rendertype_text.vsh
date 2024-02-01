#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;
uniform float GameTime;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out float modify;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    // floop what is this lol
    // no clue honestly (just commented it out)
    // modify = 0.0;
    // if (Position.z == 100) {modify==1.0;}

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;

    
    // Millo's Magic
    vec2 sampleSize = textureSize(Sampler0, 0);
    vec2 pixelSize = 1f / sampleSize;
    float vertexID = mod(gl_VertexID, 4);

    // The Magic Gate
    vec4 idCol = texture(Sampler0, UV0) * 255.0;
    if (idCol.rgb == vec3(4.)) {
        float offset = pixelSize.x * ((vertexID == 2 || vertexID == 3) ? -1 : 1);
        vec4 dataPixel = texture(Sampler0, UV0 + vec2(offset, 0)) * 255.;
        vec4 sizePixel = texture(Sampler0, UV0 + vec2(offset*2, 0)) * 255.;

        //   The true magic material acquirement
        float rows = dataPixel.r;
        float cols = dataPixel.g;
        float width = dataPixel.b;
        float height = dataPixel.a;
        float totalSize = pow(2, sizePixel.r);
        float playSpeed = sizePixel.g;
        
        //   The Magic Time Refiner
        float frame = floor(mod(GameTime * playSpeed * 50, cols * rows));

        float col = mod(frame, cols);
        float row = floor(frame / cols);


        ///// The Magical Space Bender
        vec2 texCoord = UV0 + vec2(0, pixelSize.y);
        texCoord.x += width * pixelSize.x * col;
        texCoord.y += height * pixelSize.y * row;
        
        if (vertexID == 2 || vertexID == 3) texCoord.x += (width - totalSize) * pixelSize.x;
        if (vertexID == 1 || vertexID == 2) texCoord.y += (height - totalSize) * pixelSize.y;
        
        texCoord0 = texCoord;
    }



}