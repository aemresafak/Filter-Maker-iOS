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



fragment half4 grainFragment(
                         VertexOut fragColor [[stage_in]],
                         texture2d<float, access::sample>  fragCoord [[texture(0)]],
                         constant float& amount [[buffer(0)]]
                         )
{
    constexpr sampler quadSampler;
    
    
    float noise = (fract(sin(dot(fragColor.textureCoordinate, float2(12.9898,78.233)*2.0)) * 43758.5453));
    
    half4 tex = half4(fragCoord.sample(quadSampler, fragColor.textureCoordinate));
    
    
    half4 col = tex - noise * amount;

    return col;
}


