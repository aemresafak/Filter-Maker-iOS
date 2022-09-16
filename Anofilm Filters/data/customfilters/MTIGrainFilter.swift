//
//  MTIGrainFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 16.09.2022.
//

import Foundation
import MetalPetal

class MTIGrainFilter: MTIUnaryImageRenderingFilter, Codable {
    
    var amount: Float = 0
    
    override var parameters: [String: Any] {
        return ["strength": amount]
    }

    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "grainFragment", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}
