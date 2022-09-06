//
//  MTIGammaFilter.metal
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;


fragment float4 gammaFragment(VertexOut vertexIn [[stage_in]],
                             texture2d<float, access::sample> sourceTexture [[texture(0)]],
                                  constant float& gammaValue [[ buffer(1) ]])
{
    constexpr sampler quadSampler;
    half4 color = half4(sourceTexture.sample(quadSampler, vertexIn.textureCoordinate));
    
    return (pow(color.rgb, half3(gammaValue)), color.a);
}
