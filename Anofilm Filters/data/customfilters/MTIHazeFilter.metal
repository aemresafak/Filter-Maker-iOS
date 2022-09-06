//
//  MTIHazeFilter.metal
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

#include "MTIShaderLib.h"
#include <metal_stdlib>

using namespace metal;
using namespace metalpetal;



fragment half4 hazeFragment(VertexOut vertexIn [[stage_in]],
                            texture2d<float, access::sample> sourceTexture [[texture(0)]],
                            constant float& hazeDistance [[ buffer(0) ]],
                            constant float& slope [[ buffer(1) ]]
                            )
{
    constexpr sampler quadSampler;
    half4 white = half4(1.0);
    
    half d = vertexIn.textureCoordinate.y * slope + hazeDistance;
    
    half4 color = half4(sourceTexture.sample(quadSampler, vertexIn.textureCoordinate));
    color = (color - d * white) / (1.0 - d);
    
    return color;
}
