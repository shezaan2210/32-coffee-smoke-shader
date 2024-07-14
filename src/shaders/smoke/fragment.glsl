
uniform sampler2D uPerlinTexture;
uniform float uTime;
uniform vec3 uSmokeColor;


varying vec2 Vuv;


void main () {

// smoke uv scale & animate
    vec2 smokeUv = Vuv;
    smokeUv.x *= .5;
    smokeUv.y *= .4;
    smokeUv.y -= uTime * .03;

    // smoke
    float smoke = texture(uPerlinTexture, smokeUv).r;

    // easing smoke
    smoke = smoothstep(.4, 1.0, smoke);

    // edges
   
    smoke *= smoothstep(0.0, 0.1, Vuv.x);
    smoke *= 1.0 - smoothstep(0.9, 1.0, Vuv.x);
    smoke *= smoothstep(0.0, 0.1, Vuv.y);
    smoke *= smoothstep(1.0, .4, Vuv.y);

    gl_FragColor = vec4(vec3(uSmokeColor), smoke);
    // gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}