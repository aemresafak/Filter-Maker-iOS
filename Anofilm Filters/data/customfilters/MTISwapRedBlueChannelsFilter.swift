//
//  MTISwapRedBlueChannelsFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 16.09.2022.
//
import Foundation
import MetalPetal

class MTISwapRedBlueChannelsFilter: MTIUnaryImageRenderingFilter, Codable {





    override var parameters: [String: Any] {
        return [:]
    }

    override class func fragmentFunctionDescriptor() -> MTIFunctionDescriptor {
        return MTIFunctionDescriptor(name: "swapRedBlueChannels", libraryURL: MTIDefaultLibraryURLForBundle(Bundle.main))
    }
}
