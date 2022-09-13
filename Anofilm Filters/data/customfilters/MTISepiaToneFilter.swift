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
        SIMD4(0.43922, 0, 0, 0),
        SIMD4(0, 0.25882, 0, 0),
        SIMD4(0, 0, 0.07843, 0),
        SIMD4(0, 0, 0, 1)
    ])


    init() {
        super.init(matrix: MTISepiaToneFilter.sepiaToneFilter)
    }



    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

}
