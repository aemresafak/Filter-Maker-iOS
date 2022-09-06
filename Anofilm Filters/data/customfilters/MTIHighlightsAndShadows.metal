//
//  MTIHighlightsAndShadows.metal
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//


#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;

constant half3 luminanceWeighting = half3(0.2125, 0.7154, 0.0721);



fragment half4 highlightShadowFragment(VertexOut fragmentInput [[stage_in]],
                                    texture2d<float, access::sample> inputTexture [[texture(0)]],
                                constant float& shadows [[ buffer(0) ]],
                                       constant float& highlights [[ buffer(1) ]])
{
    constexpr sampler quadSampler;
    half4 color = half4(inputTexture.sample(quadSampler, fragmentInput.textureCoordinate));
    half luminance = dot(color.rgb, luminanceWeighting);
    half shadow = clamp((pow(luminance, 1.0h/(half(shadows)+1.0h)) + (-0.76)*pow(luminance, 2.0h/(half(shadows)+1.0h))) - luminance, 0.0, 1.0);
    half highlight = clamp((1.0 - (pow(1.0-luminance, 1.0/(2.0-half(highlights))) + (-0.8)*pow(1.0-luminance, 2.0/(2.0-half(highlights))))) - luminance, -1.0, 0.0);
    half3 result = half3(0.0, 0.0, 0.0) + ((luminance + shadow + highlight) - 0.0) * ((color.rgb - half3(0.0, 0.0, 0.0))/(luminance - 0.0));
    
    return half4(result.rgb, color.a);
}
