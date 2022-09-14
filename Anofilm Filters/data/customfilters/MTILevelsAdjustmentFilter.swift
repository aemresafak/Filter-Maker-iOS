//
//  MTILevelsAdjustmentFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 14.09.2022.
//

import Foundation

import Foundation
import MetalPetal
import simd

class MTILevelsAdjustmentFilter: MTIUnaryImageRenderingFilter, Codable {
    
    var minimumColor: simd_float3 = simd_float3(0,0,0)
    var middleColor: simd_float3 = simd_float3(1,1,1)
    var maximumColor: simd_float3 = simd_float3(1,1,1)
    var minOutputColor: simd_float3 = simd_float3(0,0,0)
    var maxOutputColor: simd_float3 = simd_float3(1,1,1)




    override var parameters: [String: Any] {
        return ["minimum": minimumColor,
                "middle": middleColor,
                "maximum":  maximumColor,
                "minOutput": minOutputColor,
                "maxOutput": maxOutputColor
        ]
    }

    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "levelsFragment", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}
