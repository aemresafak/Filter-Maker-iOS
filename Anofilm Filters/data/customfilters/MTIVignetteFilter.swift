//
//  MTIVignetteFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

import Foundation
import MetalPetal

class MTIVignetteFilter: MTIUnaryImageRenderingFilter {
    
    var vignetteCenter: simd_float2 = SIMD2(0.5,0.5)
    var vignetteColor: simd_float3 = SIMD3(0,0,0)
    var vignetteStart: Float = 1
    var vignetteEnd: Float = 1


    override var parameters: [String: Any] {
        return ["vignetteCenter": vignetteCenter,
                "vignetteColor": vignetteColor,
                "vignetteStart": vignetteStart,
                "vignetteEnd": vignetteEnd
        ]
    }

    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "vignetteFragment", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}
