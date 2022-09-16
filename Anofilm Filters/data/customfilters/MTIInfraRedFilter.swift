//
//  MTIInfraRedFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 16.09.2022.
//

import Foundation
import UIKit
import MetalPetal

struct MTIInfraRedFilter {
       
    static func filter(image: UIImage, orientation: UIImage.Orientation = UIImage.Orientation.up) -> MTIImage? {
        guard let blendedImage = blendImageWithItsInverted(image: image, orientation: orientation) else { return nil }
        guard let redBlueSwappedImage = redBlueChannelsSwappedVersion(of: blendedImage) else { return nil }
        
        return redBlueSwappedImage
    }
    
    private static func redBlueChannelsSwappedVersion(of image: MTIImage) -> MTIImage? {
        let filter = MTISwapRedBlueChannelsFilter()
        filter.inputImage = image
        return filter.outputImage
    }
    
    
    private static func blendImageWithItsInverted(image: UIImage, orientation: UIImage.Orientation) -> MTIImage? {
        let originalImage = MTIImage(image: image).unpremultiplyingAlpha()
        originalImage.oriented(orientation.cgImagePropertyOrientation)
        let invertFilter = MTIColorInvertFilter()
        invertFilter.inputImage = originalImage
        guard let invertedImage = invertFilter.outputImage else { return nil }
        let colorBlendFilter = MTIBlendFilter(blendMode: .color)
        colorBlendFilter.inputImage = invertedImage
        colorBlendFilter.inputBackgroundImage = originalImage
        return colorBlendFilter.outputImage
    }
    
    
    
    
}
