//
//  MTIRedLevelsAdjustment.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 16.09.2022.
//

import Foundation
import MetalPetal

class MTIRedLevelsAdjustment: MTILevelsAdjustmentFilter {


    var minimumLevel: Float = 0 {
        willSet {
            minimumColor = simd_float3(newValue, 0, 0)
        }
    }
    var middleLevel: Float = 1 {
        willSet {
            middleColor = simd_float3(newValue, 0, 0)
        }
    }
    var maximumLevel: Float = 1 {
        willSet {
            maximumColor = simd_float3(newValue, 0, 0)
        }
    }

    var minimumOutputLevel: Float = 0 {
        willSet {
            minOutputColor = simd_float3(newValue, 0, 0)
        }
    }

    var maximumOutputLevel: Float = 1 {
        willSet {
            maxOutputColor = simd_float3(newValue, 0, 0)
        }
    }

    override init() {
        super.init()
        minimumColor = simd_float3(0, 0, 0)
        middleColor = simd_float3(1, 1, 1)
        maximumColor = simd_float3(1, 1, 1)
        minOutputColor = simd_float3(0, 0, 0)
        maxOutputColor = simd_float3(1, 1, 1)
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
