//
//  FilterEditViewModel.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import Foundation
import MetalPetal


class FilterEditViewModel : ObservableObject {
    
    private var filter = AnofilmFilter()
    private var originalImage: MTIImage? = MTIImage(cgImage: UIImage(named: "sampleImage")!.cgImage!).unpremultiplyingAlpha()
    @Published var outputImage: MTIImage?
    @Published var editType = EditType.brightness
    
    init(originalImage: MTIImage? = nil) {
        if let originalImage = originalImage {
            self.originalImage = originalImage
        }
        outputImage = self.originalImage
    }
    
    /// Change brightness of filter, brightness ranges from -1 to 1 with 0 being default  value
    func adjustBrightness(_ value: Float) {
        filter.adjustBrightness(value)
        updateOutputImage()
        
    }
    
    private func updateOutputImage() {
        outputImage = filter.filterImage(image: outputImage)
    }
    
    
}
