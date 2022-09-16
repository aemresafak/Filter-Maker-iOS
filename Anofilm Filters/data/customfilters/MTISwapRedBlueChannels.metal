//
//  MTISwapRedBlueChannels.metal
//  Anofilm Filters
//
//  Created by ahmetknk on 16.09.2022.
//

#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;



fragment half4 swapRedBlueChannels(
    VertexOut fragmentInput [[stage_in]],
     texture2d<float, access::sample> inputTexture [[texture(0)]])
{
    constexpr sampler quadSampler;
    half4 color = half4(inputTexture.sample(quadSampler, fragmentInput.textureCoordinate));
    
    return half4(
     color.b,
     color.g,
    color.r,
     color.a);
}
