//
//  MTIRGBAdjustmentFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 10.09.2022.
//

import Foundation
import MetalPetal

class MTIRGBAdjustmentFilter: MTIUnaryImageRenderingFilter, Codable {


    var redAdjustment: Float = 1
    var greenAdjustment: Float = 1
    var blueAdjustment: Float = 1


    override var parameters: [String: Any] {
        return ["redAdjustment": redAdjustment,
                "greenAdjustment": greenAdjustment,
                "blueAdjustment": blueAdjustment,
        ]
    }

    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "rgbAdjustmentFragment", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}
