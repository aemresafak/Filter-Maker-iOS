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
    private var vibrance = MTIVibranceFilter()
    private var whiteBalance = MTIWhiteBalanceFilter()
    private var gamma = MTIGammaFilter()
    private var haze = MTIHazeFilter()


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

    func setVibrance(_ value: Float) { vibrance.amount = value }
    func getVibrance() -> Float { vibrance.amount }
    func resetVibrance() { vibrance.amount = 0 }

    func setWhiteBalanceTemperature(_ value: Float) { whiteBalance.temperature = value }
    func getWhiteBalanceTemperature() -> Float { whiteBalance.temperature }
    func resetWhiteBalanceTemperature() { whiteBalance.temperature = 0 }

    func setWhiteBalanceHue(_ value: Float) { whiteBalance.hue = value }
    func getWhiteBalanceHue() -> Float { whiteBalance.hue }
    func resetWhiteBalanceHue() { whiteBalance.hue = 0 }

    func setGamma(_ value: Float) { gamma.gamma = value }
    func getGamma() -> Float { gamma.gamma }
    func resetGamma() { gamma.gamma = 1.0 }
    
    func setHazeSlope(_ value: Float) { haze.slope = value }
    func getHazeSlope() -> Float { haze.slope }
    func resetHazeSlope() { haze.slope = 0 }
    
    func setHazeDistance(_ value: Float) { haze.hazeDistance = value }
    func getHazeDistance() -> Float { haze.hazeDistance }
    func resetHazeDistance() { haze.hazeDistance = 0 }
    
    


    /// returns filtered version of image
    func filterImage(image: MTIImage?) -> MTIImage? {
        guard let image = image else {
            return nil
        }

        let intermediateOutput = FilterGraph.makeImage(builder: { output in
            image => brightness => contrast =>
            saturation => exposure => vibrance => output
        })
        
        guard let intermediateOutput = intermediateOutput else {
            return nil
        }

        let output = FilterGraph.makeImage { output in
            intermediateOutput => whiteBalance => gamma => haze => output
        }
        
        
        return output
    }
}
