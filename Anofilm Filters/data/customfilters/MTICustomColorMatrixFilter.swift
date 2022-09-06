//
//  MTICustomColorMatrixFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

import Foundation
import MetalPetal

class MTICustomColorMatrixFilter: MTIUnaryImageRenderingFilter {
    var matrix: simd_float4x4
    var intensity: Float = 0
    
    init(matrix: simd_float4x4) {
        self.matrix = matrix
    }
    
    override var parameters: [String : Any] {
        return ["colorMatrix": matrix, "intensity" : intensity]
    }
    
    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "colorMatrixFragment", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}
