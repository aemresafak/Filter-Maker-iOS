//
//  AnofilmFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import Foundation
import SwiftUI
import MetalPetal

struct AnofilmFilter: Codable {
    
    var name: String
    private var brightness = MTIBrightnessFilter()
    private var contrast = MTIContrastFilter()
    private var saturation = MTISaturationFilter()
    private var exposure = MTIExposureFilter()
    private var vibrance = MTIVibranceFilter()
    private var whiteBalance = MTIWhiteBalanceFilter()
    private var gamma = MTIGammaFilter()
    private var haze = MTIHazeFilter()
    private var highlightsAndShadows = MTIHighlightsAndShadowsFilter()
    private var sepiaTone = MTISepiaToneFilter()
    private var tint = MTICustomColorMatrixFilter(matrix: MTICustomColorMatrixFilter.noColorMatrix)
    private var highlightShadowTint = MTIHighlightShadowTintFilter()
    private var vignette = MTIVignetteFilter()
    
    init(name: String = "") {
        self.name = name
    }

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
    
    func setHighlights(_ value: Float) { highlightsAndShadows.highlights = value }
    func getHighlights() -> Float { highlightsAndShadows.highlights }
    func resetHighlights() { highlightsAndShadows.highlights = 1 }
    
    func setShadows(_ value: Float) { highlightsAndShadows.shadows = value }
    func getShadows() -> Float { highlightsAndShadows.shadows }
    func resetShadows() { highlightsAndShadows.shadows = 0 }
    
    func setSepiaTone(_ value: Float) { sepiaTone.intensity = value }
    func getSepiaTone() -> Float { sepiaTone.intensity }
    func resetSepiaTone() { sepiaTone.intensity = 0 }
    
    func setTintColor(_ color: Color) { tint.matrix = MTICustomColorMatrixFilter.createMatrix(from: color) }
    func getTintColor() -> Color { MTICustomColorMatrixFilter.createColor(from: tint.matrix) }
    func resetTintColor() { tint.matrix = MTICustomColorMatrixFilter.noColorMatrix }
    
    func setTintIntensity(_ value: Float) { tint.intensity = value }
    func getTintIntensity() -> Float { tint.intensity }
    func resetTintIntensity() { tint.intensity = 0 }
    
    
    func setHighlightTintIntensity(_ value: Float) { highlightShadowTint.highlightTintIntensity = value }
    func getHighlightTintIntensity() -> Float { highlightShadowTint.highlightTintIntensity }
    func resetHighlightTintIntensity() { highlightShadowTint.highlightTintIntensity = 0 }
    
    func setShadowTintIntensity(_ value: Float) { highlightShadowTint.shadowTintIntensity = value }
    func getShadowTintIntensity() -> Float { highlightShadowTint.shadowTintIntensity }
    func resetShadowTintIntensity() { highlightShadowTint.shadowTintIntensity = 0 }

    func setHighlightTintColor(_ color: Color) { highlightShadowTint.highlightTintColor = color.createFloat3() }
    func getHighlightTintColor() -> Color { Color.createFrom(vector: highlightShadowTint.highlightTintColor) }
    
    func setShadowTintColor(_ color: Color) { highlightShadowTint.shadowTintColor = color.createFloat3() }
    func getShadowTintColor() -> Color { Color.createFrom(vector: highlightShadowTint.shadowTintColor) }
    
    func setVignetteCenterX(_ value: Float) { vignette.vignetteCenter.x = value }
    func getVignetteCenterX() -> Float { vignette.vignetteCenter.x }
    func resetVignetteCenterX() { vignette.vignetteCenter.x = 0.5}
    
    func setVignetteCenterY(_ value: Float) { vignette.vignetteCenter.y = value }
    func getVignetteCenterY() -> Float { vignette.vignetteCenter.y }
    func resetVignetteCenterY() { vignette.vignetteCenter.y = 0.5}
    
    func setVignetteColor(_ color: Color) { vignette.vignetteColor = color.createFloat3() }
    func getVignetteColor() -> Color { Color.createFrom(vector: vignette.vignetteColor) }
    
    func setVignetteStart(_ value: Float) { vignette.vignetteStart = value }
    func getVignetteStart() -> Float { vignette.vignetteStart }
    func resetVignetteStart() { vignette.vignetteStart = 1 }
    
    func setVignetteEnd(_ value: Float) { vignette.vignetteEnd = value }
    func getVignetteEnd() -> Float { vignette.vignetteEnd }
    func resetVignetteEnd() { vignette.vignetteEnd = 1 }
    
    /// returns filtered version of image
    func filterImage(image: MTIImage?) -> MTIImage? {
        guard let image = image else {
            return nil
        }

        let intermediateOutput = FilterGraph.makeImage(builder: { output in
            image => brightness => contrast => vignette =>
            saturation => exposure => vibrance => output
        })
        
        guard let intermediateOutput = intermediateOutput else {
            return nil
        }

        let output = FilterGraph.makeImage { output in
            intermediateOutput => whiteBalance => gamma => haze =>
            highlightsAndShadows => sepiaTone => tint => highlightShadowTint => output
        }
        
        
        return output
    }
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let brightness = try container.decode(Float.self, forKey: .brightness)
        let contrast = try container.decode(Float.self, forKey: .contrast)
        let saturation = try container.decode(Float.self, forKey: .saturation)
        let exposure = try container.decode(Float.self, forKey: .exposure)
        let vibrance = try container.decode(Float.self, forKey: .vibrance)
        let brightnessFilter = MTIBrightnessFilter()
        brightnessFilter.brightness = brightness
        let contrastFilter = MTIContrastFilter()
        contrastFilter.contrast = contrast
        let saturationFilter = MTISaturationFilter()
        saturationFilter.saturation = saturation
        let exposureFilter = MTIExposureFilter()
        exposureFilter.exposure = exposure
        let vibranceFilter = MTIVibranceFilter()
        vibranceFilter.amount = vibrance
        self.brightness = brightnessFilter
        self.contrast = contrastFilter
        self.saturation = saturationFilter
        self.exposure = exposureFilter
        self.vibrance = vibranceFilter
        self.whiteBalance = try container.decode(MTIWhiteBalanceFilter.self, forKey: .whiteBalance)
        self.gamma = try container.decode(MTIGammaFilter.self, forKey: .gamma)
        self.haze = try container.decode(MTIHazeFilter.self, forKey: .haze)
        self.highlightsAndShadows = try container.decode(MTIHighlightsAndShadowsFilter.self, forKey: .highlightsAndShadows)
        self.sepiaTone = try container.decode(MTISepiaToneFilter.self, forKey: .sepiaTone)
        self.tint = try container.decode(MTICustomColorMatrixFilter.self, forKey: .tint)
        self.highlightShadowTint = try container.decode(MTIHighlightShadowTintFilter.self, forKey: .highlightShadowTint)
        self.vignette = try container.decode(MTIVignetteFilter.self, forKey: .vignette)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(getBrightness(), forKey: .brightness)
        try container.encode(getContrast(), forKey: .contrast)
        try container.encode(getSaturation(), forKey: .saturation)
        try container.encode(getExposure(), forKey: .exposure)
        try container.encode(getVibrance(), forKey: .vibrance)
        try container.encode(whiteBalance, forKey: .whiteBalance)
        try container.encode(gamma, forKey: .gamma)
        try container.encode(haze, forKey: .haze)
        try container.encode(highlightsAndShadows, forKey: .highlightsAndShadows)
        try container.encode(sepiaTone, forKey: .sepiaTone)
        try container.encode(tint, forKey: .tint)
        try container.encode(highlightShadowTint, forKey: .highlightShadowTint)
        try container.encode(vignette, forKey: .vignette)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, brightness, contrast, saturation, exposure, vibrance, whiteBalance, gamma, haze, highlightsAndShadows, sepiaTone, tint, highlightShadowTint, vignette
    }
}
