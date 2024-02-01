#version 330 core

uniform sampler2D Sampler0;
uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;
uniform vec3 Position;

in vec2 surfaceCoord;
in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

// Define some constants
const float SphereRadius = 0.05;
const int NumSpheres = 10;

// Function to create a sphere
float createSphere(vec3 center, float radius) {
    vec3 eyeDir = normalize(center - vec3(ModelViewMat * vec4(0, 0, 0, 1)));
    vec3 normal = normalize(IViewRotMat * vec3(0, 0, 1));
    float dotProduct = dot(eyeDir, normal);
    
    // Check if the pixel is inside the sphere
    if (dotProduct > 0.0) {
        float sphereDepth = length(center - vec3(ModelViewMat * vec4(surfaceCoord*2-1, 0, 1)));
        if (sphereDepth < radius) {
            return 1.0; // Inside the sphere, make it visible
        }
    }
    
    return 0.0; // Not inside the sphere, make it transparent
}

void main() {
    //vec4(surfaceCoord*2-1, 0, 1)
    vec3 worldCoord = Position;

    vec3 voidColor = vec3(.1, .1, .3);
    vec3 sphereColor = vec3(1.);

    vec3 sphereCenter = vec3(0.0, 0.0, 0.5);
    float sphereRadius = 0.5;

    float distToSphere = length(worldCoord.xyz - sphereCenter);

    vec3 color = mix(sphereColor, voidColor, smoothstep(sphereRadius - 0.01, sphereRadius + 0.01, distToSphere));

    fragColor = vec4(worldCoord, 1.);

    
    //vec4(voidColor, 1.);
    
    /*
    vec3 testSphereCenter = vec3(0.1, 0.0, 0.0); // Place the sphere behind the plane
    vec3 testVoidEffectColor = vec3(0.2, 0.2, 0.2); // Dark gray void color

    // Create the "void" effect using a noise function or any other method you prefer
    float voidEffect = smoothstep(0.0, 1.0, 1.0 - (worldCoord.z / -2.0))/* Calculate the void effect here ;
    
    // Create and place spheres in the void
    float sphereEffect = 0.0;
    for (int i = 0; i < NumSpheres; i++) {
        vec3 sphereCenter = vec3(0., 0., 0.)/* Calculate the position of the sphere ;
        sphereEffect += createSphere(testSphereCenter, SphereRadius);
    }
    
    // Combine the void effect and sphere effect to get the final color
    vec3 finalColor = mix(vec3(0.0), testVoidEffectColor, voidEffect) + mix(vec3(0.0), vec3(1.0), sphereEffect);
    
    // Apply fog based on fragment depth
    float depth = -worldCoord.z;
    float fogFactor = clamp((depth - FogStart) / (FogEnd - FogStart), 0.0, 1.0);
    finalColor = mix(finalColor, FogColor.rgb, fogFactor);
    
    // Apply vertex color and color modulator
    //finalColor *= vertexColor.rgb * ColorModulator.rgb;
    
    fragColor = vec4(finalColor, 1.0);
    */
}
