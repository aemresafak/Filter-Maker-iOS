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
               texture2d<float, access::sample> fragCoord,
               constant float& strength [[buffer(0)]]
               )
{

    constexpr sampler quadSampler;

    float x = (fragColor.textureCoordinate.x + 4.0 ) * (fragColor.textureCoordinate.y + 4.0 ) * 100;
    half4 grain = half4(mod((mod(x, 13.0) + 1.0) * (mod(x, 123.0) + 1.0), 0.01)-0.005) * strength;
    half4 col = half4(fragCoord.sample(quadSampler, fragColor.textureCoordinate)) + grain;
    return col;
}

