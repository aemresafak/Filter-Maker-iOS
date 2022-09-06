//
//  MTIHighlightShadowTintFilter.metal
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;



constant half3 luminanceWeighting = half3(0.2125, 0.7154, 0.0721);


fragment half4 highlightShadowTintFragment(VertexOut fragmentInput [[stage_in]],
                                texture2d<float, access::sample> inputTexture [[texture(0)]],
                                           constant float& shadowTintIntensity [[buffer(0)]],
                                           constant float& highlightTintIntensity [[buffer(1)]],
                                           constant float3& shadowTintColor [[buffer(2)]],
                                           constant float3& highlightTintColor [[buffer(3)]]
                                           )
{
    constexpr sampler quadSampler;
    half4 color = half4(inputTexture.sample(quadSampler, fragmentInput.textureCoordinate));
    
    half luminance = dot(color.rgb, luminanceWeighting);
    
    half4 shadowResult = mix(color, max(color, half4( mix(half3(shadowTintColor), color.rgb, luminance), color.a)), half(shadowTintIntensity));
    half4 highlightResult = mix(color, min(shadowResult, half4( mix(shadowResult.rgb, half3(highlightTintColor), luminance), color.a)), half(highlightTintIntensity));
    
    return half4(mix(shadowResult.rgb, highlightResult.rgb, luminance), color.a);
}
