//
//  MTIHighlightsAndShadowsFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

import Foundation
import MetalPetal

class MTIHighlightsAndShadows: MTIUnaryImageRenderingFilter {
    var highlights: Float = 1
    var shadows: Float = 0
    
    override var parameters: [String : Any] {
        return ["highlights": highlights, "shadows" : shadows]
    }
    
    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "highlightShadowFragment", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}
