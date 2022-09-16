//
//  AnofilmFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import Foundation
import SwiftUI
import MetalPetal

struct AnofilmFilter: Codable, Identifiable {
    var id: UUID = UUID()
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
    private var rgbAdjustment = MTIRGBAdjustmentFilter()
    private var clahe = MTICLAHEFilter()
    private var rgbLevels = MTIRGBLevelsAdjustmentFilter()
    private var redLevels = MTIRedLevelsAdjustment()

    init(name: String = "") {
        self.name = name
        clahe.clipLimit = 0
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
    func resetVignetteCenterX() { vignette.vignetteCenter.x = 0.5 }

    func setVignetteCenterY(_ value: Float) { vignette.vignetteCenter.y = value }
    func getVignetteCenterY() -> Float { vignette.vignetteCenter.y }
    func resetVignetteCenterY() { vignette.vignetteCenter.y = 0.5 }

    func setVignetteColor(_ color: Color) { vignette.vignetteColor = color.createFloat3() }
    func getVignetteColor() -> Color { Color.createFrom(vector: vignette.vignetteColor) }

    func setVignetteStart(_ value: Float) { vignette.vignetteStart = value }
    func getVignetteStart() -> Float { vignette.vignetteStart }
    func resetVignetteStart() { vignette.vignetteStart = 1 }

    func setVignetteEnd(_ value: Float) { vignette.vignetteEnd = value }
    func getVignetteEnd() -> Float { vignette.vignetteEnd }
    func resetVignetteEnd() { vignette.vignetteEnd = 1 }

    func setRedAdjustment(_ value: Float) { rgbAdjustment.redAdjustment = value }
    func getRedAdjustment() -> Float { rgbAdjustment.redAdjustment }
    func resetRedAdjustment() { rgbAdjustment.redAdjustment = 1 }


    func setGreenAdjustment(_ value: Float) { rgbAdjustment.greenAdjustment = value }
    func getGreenAdjustment() -> Float { rgbAdjustment.greenAdjustment }
    func resetGreenAdjustment() { rgbAdjustment.greenAdjustment = 1 }

    func setBlueAdjustment(_ value: Float) { rgbAdjustment.blueAdjustment = value }
    func getBlueAdjustment() -> Float { rgbAdjustment.blueAdjustment }
    func resetBlueAdjustment() { rgbAdjustment.blueAdjustment = 1 }

    func setClaheClipLimit(_ value: Float) { clahe.clipLimit = value }
    func getClaheClipLimit() -> Float { clahe.clipLimit }
    func resetClaheClipLimit() { clahe.clipLimit = 0 }

    func setClaheTileWidth(_ value: UInt) { clahe.tileGridSize.width = value }
    func getClaheTileWidth() -> UInt { clahe.tileGridSize.width }
    func resetClaheTileWidth() { clahe.tileGridSize.width = 8 }

    func setClaheTileHeight(_ value: UInt) { clahe.tileGridSize.height = value }
    func getClaheTileHeight() -> UInt { clahe.tileGridSize.height }
    func resetClaheTileHeight() { clahe.tileGridSize.height = 8 }

    func setMinimumRGBLevel(_ value: Float) { rgbLevels.minimumLevel = value }
    func getMinimumRGBLevel() -> Float { rgbLevels.minimumLevel }
    func resetMinimumRGBLevel() { rgbLevels.minimumLevel = 0 }

    func setMiddleRGBLevel(_ value: Float) { rgbLevels.middleLevel = value }
    func getMiddleRGBLevel() -> Float { rgbLevels.middleLevel }
    func resetMiddleRGBLevel() { rgbLevels.middleLevel = 1 }

    func setMaximumRGBLevel(_ value: Float) { rgbLevels.maximumLevel = value }
    func getMaximumRGBLevel() -> Float { rgbLevels.maximumLevel }
    func resetMaximumRGBLevel() { rgbLevels.maximumLevel = 0 }

    func setMinimumOutputRGBLevel(_ value: Float) { rgbLevels.minimumOutputLevel = value }
    func getMinimumOutputRGBLevel() -> Float { rgbLevels.minimumOutputLevel }
    func resetMinimumOutputRGBLevel() { rgbLevels.minimumOutputLevel = 0 }
    
    func setMaximumOutputRGBLevel(_ value: Float) { rgbLevels.maximumOutputLevel = value }
    func getMaximumOutputRGBLevel() -> Float { rgbLevels.maximumOutputLevel }
    func resetMaximumOutputRGBLevel() { rgbLevels.maximumOutputLevel = 1 }
    
    func setMinimumRedLevel(_ value: Float) { redLevels.minimumLevel = value}
    func getMinimumRedLevel() -> Float { redLevels.minimumLevel}
    func resetMinimumRedLevel() { redLevels.minimumLevel = 0}
    
    
    func setMiddleRedLevel(_ value: Float) { redLevels.middleLevel = value}
    func getMiddleRedLevel() -> Float { redLevels.middleLevel}
    func resetMiddleRedLevel() { redLevels.middleLevel = 1}
    
    func setMaximumRedLevel(_ value: Float) { redLevels.maximumLevel = value}
    func getMaximumRedLevel() -> Float { redLevels.maximumLevel}
    func resetMaximumRedLevel() { redLevels.maximumLevel = 1}
    
    func setMinimumOutputRedLevel(_ value: Float) { redLevels.minimumOutputLevel = value}
    func getMinimumOutputRedLevel() -> Float { redLevels.minimumOutputLevel}
    func resetMinimumOutputRedLevel() { redLevels.minimumOutputLevel = 0}
    
    func setMaximumOutputRedLevel(_ value: Float) { redLevels.maximumOutputLevel = value}
    func getMaximumOutputRedLevel() -> Float { redLevels.maximumOutputLevel}
    func resetMaximumOutputRedLevel() { redLevels.maximumOutputLevel = 1}
    
    /// returns filtered version of image
    func filterImage(image: MTIImage?) -> MTIImage? {
        guard let image = image else {
            return nil
        }

        let intermediateOutput = FilterGraph.makeImage(builder: { output in
            image => brightness => contrast => vignette =>
            rgbAdjustment => clahe =>
            saturation => exposure => vibrance => output
        })

        guard let intermediateOutput = intermediateOutput else {
            return nil
        }
        

        let intermediateOutput2 = FilterGraph.makeImage { output in
            intermediateOutput => whiteBalance => gamma => haze =>
            highlightsAndShadows => sepiaTone => tint => highlightShadowTint => output
        }
        
        guard let intermediateOutput2 = intermediateOutput2 else {
            return nil
        }

        let output = FilterGraph.makeImage { output in
            intermediateOutput2 => rgbLevels => redLevels => output
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
        self.rgbAdjustment = try container.decode(MTIRGBAdjustmentFilter.self, forKey: .rgbAdjustment)
        let claheBlueprint = try container.decode(MTICLAHEFilterBluePrint.self, forKey: .clahe)
        self.clahe = claheBlueprint.createMTICLAHEFilter()
        self.rgbLevels = try container.decode(MTIRGBLevelsAdjustmentFilter.self, forKey: .rgbLevels)
        self.redLevels = try container.decode(MTIRedLevelsAdjustment.self, forKey: .redLevels)
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
        try container.encode(rgbAdjustment, forKey: .rgbAdjustment)
        try container.encode(clahe.createBlueprint(), forKey: .clahe)
        try container.encode(rgbLevels, forKey: .rgbLevels)
        try container.encode(redLevels, forKey: .redLevels)
    }

    private enum CodingKeys: String, CodingKey {
        case name, brightness, contrast, saturation, exposure, vibrance
        case whiteBalance, gamma, haze, highlightsAndShadows
        case sepiaTone, tint, highlightShadowTint, vignette, rgbAdjustment
        case clahe, rgbLevels, redLevels
    }

    var description: String {
        """
        Filter Name:    \(name)
        Brightness Value:    \(brightness.brightness)
        Contrast Value:    \(contrast.contrast)
        Saturation Value:    \(saturation.saturation)
        Exposure Value:    \(exposure.exposure)
        Vibrance Value:    \(vibrance.amount)
        White Balance Temperature:    \(getWhiteBalanceTemperature())
        White Balance Hue:    \(getWhiteBalanceHue())
        Gamma Value:    \(getGamma())
        Haze Distance:    \(getHazeDistance())
        Haze Slope:    \(getHazeSlope())
        Highlights:    \(getHighlights())
        Shadows:    \(getShadows())
        Sepia Tone:    \(getSepiaTone())
        Tint Color Description:    \(getTintColor().description)
        Tint Color Intensity:    \(getTintIntensity())
        Highlight Tint Color:    \(getHighlightTintColor())
        Highlight Tint Intensity:    \(getHighlightTintIntensity())
        Shadow Tint Color:    \(getShadowTintColor())
        Shadow Tint Intensity:    \(getShadowTintIntensity())
        Vignette Center X:    \(getVignetteCenterX())
        Vignette Center Y:    \(getVignetteCenterY())
        Vignette Color Description:    \(getVignetteColor().description)
        Vignette Start:    \(getVignetteStart())
        Vignette End:    \(getVignetteEnd())
        Red Adjustment:  \(getRedAdjustment())
        Green Adjustment:  \(getGreenAdjustment())
        Blue Adjustment:  \(getBlueAdjustment())
        CLAHE Clip Limit:  \(clahe.clipLimit)
        CLAHE Grid Tile Width:  \(clahe.tileGridSize.width)
        CLAHE Grid Tile Height: \(clahe.tileGridSize.height)
        RGB Minimum Level:  \(rgbLevels.minimumLevel)
        RGB Middle Level:  \(rgbLevels.middleLevel)
        RGB Maximum Level:  \(rgbLevels.maximumLevel)
        RGB Minimum Output Level:  \(rgbLevels.minimumOutputLevel)
        RGB Maximum Output Level:  \(rgbLevels.maximumOutputLevel)
        Red Minimum Level:  \(redLevels.minimumLevel)
        Red Middle Level:  \(redLevels.middleLevel)
        Red Maximum Level:  \(redLevels.maximumLevel)
        Red Minimum Output Level:  \(redLevels.minimumOutputLevel)
        Red Maximum Output Level:  \(redLevels.maximumOutputLevel)
        """
    }
}
