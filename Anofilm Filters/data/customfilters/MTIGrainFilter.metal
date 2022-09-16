//
//  MTIGrainFilter.metal
//  Anofilm Filters
//
//  Created by ahmetknk on 16.09.2022.
//
#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;



fragment half4 mainImage(
                         VertexOut fragColor [[stage_in]],
                         texture2d<float, access::sample>  fragCoord [[texture(0)]]
                         )
{
    constexpr sampler quadSampler;
    
    
    // Calculate noise and sample texture
    float mdf = 0.1; // increase for noise amount
    float noise = (fract(sin(dot(fragColor.textureCoordinate, float2(12.9898,78.233)*2.0)) * 43758.5453));
    
    half4 tex = half4(fragCoord.sample(quadSampler, fragColor.textureCoordinate));
    
    
    half4 col = tex - noise * mdf;

    return col;
}


