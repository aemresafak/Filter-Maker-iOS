//
//  MTILevelsAdjustmentFilter.metal
//  Anofilm Filters
//
//  Created by ahmetknk on 14.09.2022.
//

#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;


// Possibly convert these to functions
#define LevelsControlInputRange(color, minInput, maxInput)     min(max(color - minInput, half3(0.0)) / (maxInput - minInput), half3(1.0))
#define LevelsControlInput(color, minInput, gamma, maxInput)   GammaCorrection(LevelsControlInputRange(color, minInput, maxInput), gamma)
#define LevelsControlOutputRange(color, minOutput, maxOutput)   mix(minOutput, maxOutput, color)
#define LevelsControl(color, minInput, gamma, maxInput, minOutput, maxOutput)  LevelsControlOutputRange(LevelsControlInput(color, minInput, gamma, maxInput), minOutput, maxOutput)

 /*
 ** Gamma correction
 ** Details: http://blog.mouaif.org/2009/01/22/photoshop-gamma-correction-shader/
 */
#define GammaCorrection(color, gamma)  pow(color, 1.0 / gamma)

 
/*
 ** Levels control (input (+gamma), output)
 ** Details: http://blog.mouaif.org/2009/01/28/levels-control-shader/
 */

fragment half4 levelsFragment(
                            VertexOut fragmentInput [[stage_in]],
                            texture2d<half> inputTexture [[texture(0)]],
                            constant float3& minimum [[buffer(0)]],
                            constant float3& middle [[buffer(1)]],
                            constant float3& maximum [[buffer(2)]],
                            constant float3& minOutput [[buffer(3)]],
                            constant float3& maxOutput [[buffer(4)]]
                    )
{
    constexpr sampler quadSampler;
    half4 color = half4(inputTexture.sample(quadSampler, fragmentInput.textureCoordinate));
    
    return half4(LevelsControl(color.rgb, half3(minimum), half3(middle), half3(maximum), half3(minOutput), half3(maxOutput)), color.a);
}
