//
//  MTICustomColorMatrixFilter.metal
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;





fragment half4 colorMatrixFragment(VertexOut fragmentInput [[stage_in]],
                                   texture2d<float, access::sample> inputTexture [[texture(0)]],
                                   constant float4x4& colorMatrix [[ buffer(0)]],
                                   constant float& intensity [[ buffer(1)]]
                                 )
{
    constexpr sampler quadSampler;
    half4 color = half4(inputTexture.sample(quadSampler, fragmentInput.textureCoordinate));
    half4 outputColor = color * half4x4(colorMatrix);
    
    return half4(intensity * outputColor) + ((1.0 - intensity) * color);
}
