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
    private var contrast = MTIContrastFilter()
    private var saturation = MTISaturationFilter()
    private var exposure = MTIExposureFilter()


    /// value of brightness in range of -1 to 1 with 0 being default
    func setBrightness(_ value: Float) { brightness.brightness = value }
    func getBrightness() -> Float { brightness.brightness }
    func resetBrightness() { brightness.brightness = 0 }

    func setContrast(_ value: Float) { contrast.contrast = value }
    func getContrast() -> Float { contrast.contrast }
    func resetContrast() { contrast.contrast = 0 }

    func setSaturation(_ value: Float) { saturation.saturation = value }
    func getSaturation() -> Float { saturation.saturation }
    func resetSaturation() { saturation.saturation = 0 }

    func setExposure(_ value: Float) { exposure.exposure = value }
    func getExposure() -> Float { exposure.exposure }
    func resetExposure() { exposure.exposure = 0 }



    /// returns filtered version of image
    func filterImage(image: MTIImage?) -> MTIImage? {
        guard let image = image else {
            return nil
        }

        let output = FilterGraph.makeImage(builder: { output in
            image => brightness => contrast => saturation =>
            exposure => output
        })
        return output
    }
}
