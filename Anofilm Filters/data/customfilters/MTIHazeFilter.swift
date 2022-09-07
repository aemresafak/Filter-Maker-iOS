//
//  MTIHazeFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

import Foundation
import MetalPetal


class MTIHazeFilter: MTIUnaryImageRenderingFilter, Codable {
    var hazeDistance: Float = 0
    var slope: Float = 0
    
    override var parameters: [String : Any] {
        return ["hazeDistance": hazeDistance, "slope" : slope]
    }
    
    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "hazeFragment", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}
