//
//  MTIWhiteBalanceFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

import Foundation
import MetalPetal


class MTIWhiteBalanceFilter: MTIUnaryImageRenderingFilter, Codable {
    var temperature: Float = 0
    var hue: Float = 0
    
    override var parameters: [String : Any] {
        return ["temperature": temperature, "hue" : hue]
    }
    
    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "whiteBalance", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}
