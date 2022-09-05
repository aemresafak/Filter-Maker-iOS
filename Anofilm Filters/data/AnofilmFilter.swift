//
//  AnofilmFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import Foundation
import MetalPetal

struct AnofilmFilter {

    private var brightness = MTIBrightnessFilter()


    /// value of brightness in range of -1 to 1 with 0 being default
    func adjustBrightness(_ value: Float) {
        brightness.brightness = value
    }

    /// returns filtered version of image
    func filterImage(image: MTIImage?) -> MTIImage? {
        guard let image = image else {
            return nil
        }

        let output = FilterGraph.makeImage(builder: { output in
            image => brightness => output
        })
        return output
    }
}
