//
//  MTIGammaFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

import Foundation
import MetalPetal


class MTIGammaFilter: MTIUnaryImageRenderingFilter {
    var gamma: Float = 1
    
    override var parameters: [String : Any] {
        return ["gammaValue": gamma]
    }
    
    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "gammaFragment", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}

