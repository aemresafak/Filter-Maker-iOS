//
//  MTIRGBAdjustmentFilter.metal
//  Anofilm Filters
//
//  Created by ahmetknk on 10.09.2022.
//

#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;

fragment half4 rgbAdjustmentFragment(VertexOut fragmentInput [[stage_in]],
                             texture2d<float, access::sample> inputTexture [[texture(0)]],
                                     constant float& redAdjustment [[ buffer(0)]],
                                     constant float& greenAdjustment [[ buffer(1)]],
                                     constant float& blueAdjustment [[ buffer(2)]]
                        )
{
    constexpr sampler quadSampler;
    half4 color = half4(inputTexture.sample(quadSampler, fragmentInput.textureCoordinate));
    
    return half4(color.r * redAdjustment,
                 color.g * greenAdjustment,
                 color.b * blueAdjustment,
                 color.a);
}
