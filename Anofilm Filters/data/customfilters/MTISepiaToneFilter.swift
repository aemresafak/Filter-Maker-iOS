//
//  MTISepiaToneFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

import Foundation
import MetalPetal

class MTISepiaToneFilter: MTICustomColorMatrixFilter {
    static let sepiaToneFilter = simd_float4x4(rows: [
        SIMD4(0.3588, 0.7044, 0.1368, 0),
        SIMD4(0.2990, 0.5870, 0.1140, 0),
        SIMD4(0.2392, 0.4696, 0.0912, 0),
        SIMD4(0,0,0,1)
    ])
    
   
    init() {
        super.init(matrix: MTISepiaToneFilter.sepiaToneFilter)
    }
    
   
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
}
