//
//  MTIVignetteFilter.metal
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;



fragment half4 vignetteFragment(VertexOut fragmentInput [[stage_in]],
                                texture2d<float, access::sample> inputTexture [[texture(0)]],
                                constant float2& vignetteCenter [[buffer(0)]],
                                constant float3& vignetteColor  [[buffer(1)]],
                                constant float& vignetteStart [[buffer(2)]],
                                constant float& vignetteEnd [[buffer(3)]]
                                       )
{
    constexpr sampler quadSampler;
    half4 color = half4(inputTexture.sample(quadSampler, fragmentInput.textureCoordinate));
    
    float d = distance(fragmentInput.textureCoordinate, float2(vignetteCenter.x, vignetteCenter.y));
    float percent = smoothstep(vignetteStart, vignetteEnd, d);
    return half4(mix(color.rgb, half3(vignetteColor), half(percent)), color.a);
}
