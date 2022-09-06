//
//  MTIHighlightShadowTintFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

import Foundation
import MetalPetal


class MTIHighlightShadowTintFilter: MTIUnaryImageRenderingFilter {
    var highlightTintIntensity: Float = 0
    var shadowTintIntensity: Float = 0
    var highlightTintColor: simd_float3 = SIMD3(1, 1, 1)
    var shadowTintColor: simd_float3 = SIMD3(1, 1, 1)


    override var parameters: [String: Any] {
        return ["shadowTintIntensity": shadowTintIntensity,
                "highlightTintIntensity": highlightTintIntensity,
                "highlightTintColor": highlightTintColor,
                "shadowTintColor": shadowTintColor
        ]
    }

    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "highlightShadowTintFragment", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}
