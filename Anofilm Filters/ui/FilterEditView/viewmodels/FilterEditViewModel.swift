//
//  FilterEditViewModel.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import Foundation
import MetalPetal
import UIKit
import SwiftUI


class FilterEditViewModel: ObservableObject {

    var filter: AnofilmFilter = AnofilmFilter()
    private var originalImage: MTIImage? = MTIImage(cgImage: UIImage(named: "sampleImage")!.cgImage!).unpremultiplyingAlpha()
    private let context: MTIContext? = try? MTIContext(device: MTLCreateSystemDefaultDevice()!)

    @Published var outputImage: MTIImage?
    @Published var editType = EditType.brightness
    @Published var filterName: String = ""
    @Published var vignetteColor: Color = Color.black {
        didSet {
            filter.setVignetteColor(vignetteColor)
            updateOutputImage()
        }
    }
    @Published var secondaryVignetteColor: Color = Color.black {
        didSet {
            filter.setSecondaryVignetteColor(secondaryVignetteColor)
            updateOutputImage()
        }
    }
    @Published var tintColor: Color = Color.white {
        didSet {
            filter.setTintColor(tintColor)
            updateOutputImage()
        }
    }
    @Published var highlightTintColor: Color = Color.white {
        didSet {
            filter.setHighlightTintColor(highlightTintColor)
            updateOutputImage()
        }
    }
    @Published var shadowTintColor: Color = Color.white {
        didSet {
            filter.setShadowTintColor(shadowTintColor)
            updateOutputImage()
        }
    }


    private var isFilterUpdated = false
    private var restoreData: Data?
    var storedFilter: AnofilmFilter? {
        if let restoreData = restoreData {
            return try? JSONDecoder().decode(AnofilmFilter.self, from: restoreData)
        } else {
            return nil
        }

    }


    init() {
        outputImage = self.originalImage
        vignetteColor = filter.getVignetteColor()
        tintColor = filter.getTintColor()
        highlightTintColor = filter.getHighlightTintColor()
        shadowTintColor = filter.getShadowTintColor()
        updateOutputImage()
    }

    func updateFilter(filter: AnofilmFilter) {
        if isFilterUpdated {
            return
        }
        self.filter = filter
        updateOutputImage()
        filterName = filter.name
        vignetteColor = filter.getVignetteColor()
        tintColor = filter.getTintColor()
        highlightTintColor = filter.getHighlightTintColor()
        shadowTintColor = filter.getShadowTintColor()
        isFilterUpdated = true
        restoreData = try? JSONEncoder().encode(filter)
    }


    func saveImageToDocuments(onSaveCallback: (() -> Void)? = nil) {
        Task {
            guard let outputImage = outputImage else {
                return
            }
            guard let cgImage = try? context?.makeCGImage(from: outputImage) else {
                return
            }
            let uiImage = UIImage(cgImage: cgImage)
            let imageSaver = ImageSaver(onSuccess: { _ in
                Task {
                    await MainActor.run {
                        onSaveCallback?.self()
                    }
                }
            }) { _, error in
                print(error.localizedDescription)
            }
            imageSaver.saveImageToPhotos(uiImage)

        }

    }



    /// Change brightness of filter, brightness ranges from -1 to 1 with 0 being default  value
    func setBrightness(_ value: Float) {
        filter.setBrightness(value)
        updateOutputImage()
    }

    func getBrightness() -> Float { filter.getBrightness() }
    func resetBrightness() { filter.resetBrightness() }

    func setContrast(_ value: Float) {
        filter.setContrast(value)
        updateOutputImage()
    }

    func getContrast() -> Float { filter.getContrast() }
    func resetContrast() { filter.resetContrast() }

    func setSaturation(_ value: Float) {
        filter.setSaturation(value)
        updateOutputImage()
    }

    func getSaturation() -> Float { filter.getSaturation() }
    func resetSaturation() { filter.resetSaturation() }

    func setExposure(_ value: Float) {
        filter.setExposure(value)
        updateOutputImage()
    }

    func getExposure() -> Float { filter.getExposure() }
    func resetExposure() { filter.resetExposure() }

    func setVibrance(_ value: Float) {
        filter.setVibrance(value)
        updateOutputImage()
    }

    func getVibrance() -> Float { filter.getVibrance() }
    func resetVibrance() { filter.resetVibrance() }

    func setWhiteBalanceTemperature(_ value: Float) {
        filter.setWhiteBalanceTemperature(value)
        updateOutputImage()
    }

    func getWhiteBalanceTemperature() -> Float { filter.getWhiteBalanceTemperature() }
    func resetWhiteBalanceTemperature() { filter.resetWhiteBalanceTemperature() }

    func setWhiteBalanceHue(_ value: Float) {
        filter.setWhiteBalanceHue(value)
        updateOutputImage()
    }

    func getWhiteBalanceHue() -> Float { filter.getWhiteBalanceHue() }
    func resetWhiteBalanceHue() { filter.resetWhiteBalanceHue() }

    func setGamma(_ value: Float) {
        filter.setGamma(value)
        updateOutputImage()
    }

    func getGamma() -> Float { filter.getGamma() }
    func resetGamma() { filter.resetGamma() }

    func setHazeDistance(_ value: Float) {
        filter.setHazeDistance(value)
        updateOutputImage()
    }

    func getHazeDistance() -> Float { filter.getHazeDistance() }
    func resetHazeDistance() { filter.resetHazeDistance() }

    func setHazeSlope(_ value: Float) {
        filter.setHazeSlope(value)
        updateOutputImage()
    }
    func getHazeSlope() -> Float { filter.getHazeSlope() }
    func resetHazeSlope() { filter.resetHazeSlope() }

    func setHighlights(_ value: Float) {
        filter.setHighlights(value)
        updateOutputImage()
    }
    func getHighlights() -> Float { filter.getHighlights() }
    func resetHighlights() { filter.resetHighlights() }

    func setShadows(_ value: Float) {
        filter.setShadows(value)
        updateOutputImage()
    }
    func getShadows() -> Float { filter.getShadows() }
    func resetShadows() { filter.resetShadows() }

    func setSepiaTone(_ value: Float) {
        filter.setSepiaTone(value)
        updateOutputImage()
    }
    func getSepiaTone() -> Float { filter.getSepiaTone() }
    func resetSepiaTone() { filter.resetSepiaTone() }

    func setTintColor(_ color: Color) {
        filter.setTintColor(color)
        updateOutputImage()
    }
    func getTintColor() -> Color { filter.getTintColor() }
    func resetTintColor() { filter.resetTintColor() }

    func setTintIntensity(_ value: Float) {
        filter.setTintIntensity(value)
        updateOutputImage()
    }

    func getTintIntensity() -> Float { filter.getTintIntensity() }
    func resetTintIntensity() { filter.resetTintIntensity() }

    func setHighlightTintIntensity(_ value: Float) {
        filter.setHighlightTintIntensity(value)
        updateOutputImage()
    }
    func getHighlightTintIntensity() -> Float { filter.getHighlightTintIntensity() }
    func resetHighlightTintIntenstity() { filter.resetHighlightTintIntensity() }

    func setShadowTintIntensity(_ value: Float) {
        filter.setShadowTintIntensity(value)
        updateOutputImage()
    }
    func getShadowTintIntensity() -> Float { filter.getShadowTintIntensity() }
    func resetShadowTintIntensity() { filter.resetShadowTintIntensity() }

    func setHighlightTintColor(_ color: Color) {
        filter.setHighlightTintColor(color)
        updateOutputImage()
    }
    func getHighlightTintColor() -> Color { filter.getHighlightTintColor() }

    func setShadowTintColor(_ color: Color) {
        filter.setShadowTintColor(color)
        updateOutputImage()
    }
    func getShadowTintColor() -> Color { filter.getShadowTintColor() }

    func setVignetteCenterX(_ value: Float) {
        filter.setVignetteCenterX(value)
        updateOutputImage()
    }
    func getVignetteCenterX() -> Float { filter.getVignetteCenterX() }
    func resetVignetteCenterX() { filter.resetVignetteCenterX() }


    func setVignetteCenterY(_ value: Float) {
        filter.setVignetteCenterY(value)
        updateOutputImage()
    }
    func getVignetteCenterY() -> Float { filter.getVignetteCenterY() }
    func resetVignetteCenterY() { filter.resetVignetteCenterY() }

    func setVignetteColor(_ color: Color) {
        filter.setVignetteColor(color)
        updateOutputImage()
    }
    func getVignetteColor() -> Color { filter.getVignetteColor() }

    func setVignetteStart(_ value: Float) {
        filter.setVignetteStart(value)
        updateOutputImage()
    }
    func getVignetteStart() -> Float { filter.getVignetteStart() }
    func resetVignetteStart() { filter.resetVignetteStart() }

    func setVignetteEnd(_ value: Float) {
        filter.setVignetteEnd(value)
        updateOutputImage()
    }
    func getVignetteEnd() -> Float { filter.getVignetteEnd() }
    func resetVignetteEnd() { filter.resetVignetteEnd() }

    func setSecondaryVignetteCenterX(_ value: Float) {
        filter.setSecondaryVignetteCenterX(value)
        updateOutputImage()
    }
    func getSecondaryVignetteCenterX() -> Float { filter.getSecondaryVignetteCenterX() }
    func resetSecondaryVignetteCenterX() { filter.resetSecondaryVignetteCenterX() }


    func setSecondaryVignetteCenterY(_ value: Float) {
        filter.setSecondaryVignetteCenterY(value)
        updateOutputImage()
    }
    func getSecondaryVignetteCenterY() -> Float { filter.getSecondaryVignetteCenterY() }
    func resetSecondaryVignetteCenterY() { filter.resetSecondaryVignetteCenterY() }

    func setSecondaryVignetteColor(_ color: Color) {
        filter.setSecondaryVignetteColor(color)
        updateOutputImage()
    }
    func getSecondaryVignetteColor() -> Color { filter.getSecondaryVignetteColor() }

    func setSecondaryVignetteStart(_ value: Float) {
        filter.setSecondaryVignetteStart(value)
        updateOutputImage()
    }
    func getSecondaryVignetteStart() -> Float { filter.getSecondaryVignetteStart() }
    func resetSecondaryVignetteStart() { filter.resetSecondaryVignetteStart() }

    func setSecondaryVignetteEnd(_ value: Float) {
        filter.setSecondaryVignetteEnd(value)
        updateOutputImage()
    }
    func getSecondaryVignetteEnd() -> Float { filter.getSecondaryVignetteEnd() }
    func resetSecondaryVignetteEnd() { filter.resetSecondaryVignetteEnd() }



    func setRedAdjustment(_ value: Float) {
        filter.setRedAdjustment(value)
        updateOutputImage()
    }
    func getRedAdjustment() -> Float { filter.getRedAdjustment() }
    func resetRedAdjustment() { filter.resetRedAdjustment() }

    func setGreenAdjustment(_ value: Float) {
        filter.setGreenAdjustment(value)
        updateOutputImage()
    }
    func getGreenAdjustment() -> Float { filter.getGreenAdjustment() }
    func resetGreenAdjustment() { filter.resetGreenAdjustment() }

    func setBlueAdjustment(_ value: Float) {
        filter.setBlueAdjustment(value)
        updateOutputImage()
    }
    func getBlueAdjustment() -> Float { filter.getBlueAdjustment() }
    func resetBlueAdjustment() { filter.resetBlueAdjustment() }

    func setClaheClipLimit(_ value: Float) {
        filter.setClaheClipLimit(value)
        updateOutputImage()
    }
    func getClaheClipLimit() -> Float { filter.getClaheClipLimit() }
    func resetClaheClipLimit() { filter.resetClaheClipLimit() }

    func setClaheTileWidth(_ value: UInt) {
        filter.setClaheTileWidth(value)
        updateOutputImage()
    }
    func getClaheTileWidth() -> UInt { filter.getClaheTileWidth() }
    func resetClaheTileWidth() { filter.resetClaheTileWidth() }

    func setClaheTileHeight(_ value: UInt) {
        filter.setClaheTileHeight(value)
        updateOutputImage()
    }
    func getClaheTileHeight() -> UInt { filter.getClaheTileHeight() }
    func resetClaheTileHeight() { filter.resetClaheTileHeight() }

    func setMinimumRGBLevel(_ value: Float) {
        filter.setMinimumRGBLevel(value)
        updateOutputImage()
    }
    func getMinimumRGBLevel() -> Float { filter.getMinimumRGBLevel() }
    func resetMinimumRGBLevel() { filter.resetMinimumRGBLevel() }

    func setMiddleRGBLevel(_ value: Float) {
        filter.setMiddleRGBLevel(value)
        updateOutputImage()
    }
    func getMiddleRGBLevel() -> Float { filter.getMiddleRGBLevel() }
    func resetMiddleRGBLevel() { filter.resetMiddleRGBLevel() }

    func setMaximumRGBLevel(_ value: Float) {
        filter.setMaximumRGBLevel(value)
        updateOutputImage()
    }
    func getMaximumRGBLevel() -> Float { filter.getMaximumRGBLevel() }
    func resetMaximumRGBLevel() { filter.resetMaximumRGBLevel() }

    func setMinimumOutputRGBLevel(_ value: Float) {
        filter.setMinimumOutputRGBLevel(value)
        updateOutputImage()
    }
    func getMinimumOutputRGBLevel() -> Float { filter.getMinimumOutputRGBLevel() }
    func resetMinimumOutputRGBLevel() { filter.resetMinimumOutputRGBLevel() }

    func setMaximumOutputRGBLevel(_ value: Float) {
        filter.setMaximumOutputRGBLevel(value)
        updateOutputImage()
    }
    func getMaximumOutputRGBLevel() -> Float { filter.getMaximumOutputRGBLevel() }
    func resetMaximumOutputRGBLevel() { filter.resetMaximumOutputRGBLevel() }



    func setMinimumRedLevel(_ value: Float) {
        filter.setMinimumRedLevel(value)
        updateOutputImage()
    }
    func getMinimumRedLevel() -> Float { filter.getMinimumRedLevel() }
    func resetMinimumRedLevel() { filter.resetMinimumRedLevel() }

    func setMiddleRedLevel(_ value: Float) {
        filter.setMiddleRedLevel(value)
        updateOutputImage()
    }
    func getMiddleRedLevel() -> Float { filter.getMiddleRedLevel() }
    func resetMiddleRedLevel() { filter.resetMiddleRedLevel() }

    func setMaximumRedLevel(_ value: Float) {
        filter.setMaximumRedLevel(value)
        updateOutputImage()
    }
    func getMaximumRedLevel() -> Float { filter.getMaximumRedLevel() }
    func resetMaximumRedLevel() { filter.resetMaximumRedLevel() }

    func setMinimumOutputRedLevel(_ value: Float) {
        filter.setMinimumOutputRedLevel(value)
        updateOutputImage()
    }
    func getMinimumOutputRedLevel() -> Float { filter.getMinimumOutputRedLevel() }
    func resetMinimumOutputRedLevel() { filter.resetMinimumOutputRedLevel() }

    func setMaximumOutputRedLevel(_ value: Float) {
        filter.setMaximumOutputRedLevel(value)
        updateOutputImage()
    }
    func getMaximumOutputRedLevel() -> Float { filter.getMaximumOutputRedLevel() }
    func resetMaximumOutputRedLevel() { filter.resetMaximumOutputRedLevel() }

    func setMinimumGreenLevel(_ value: Float) {
        filter.setMinimumGreenLevel(value)
        updateOutputImage()
    }
    func getMinimumGreenLevel() -> Float { filter.getMinimumGreenLevel() }
    func resetMinimumGreenLevel() { filter.resetMinimumGreenLevel() }

    func setMiddleGreenLevel(_ value: Float) {
        filter.setMiddleGreenLevel(value)
        updateOutputImage()
    }
    func getMiddleGreenLevel() -> Float { filter.getMiddleGreenLevel() }
    func resetMiddleGreenLevel() { filter.resetMiddleGreenLevel() }

    func setMaximumGreenLevel(_ value: Float) {
        filter.setMaximumGreenLevel(value)
        updateOutputImage()
    }
    func getMaximumGreenLevel() -> Float { filter.getMaximumGreenLevel() }
    func resetMaximumGreenLevel() { filter.resetMaximumGreenLevel() }

    func setMinimumOutputGreenLevel(_ value: Float) {
        filter.setMinimumOutputGreenLevel(value)
        updateOutputImage()
    }
    func getMinimumOutputGreenLevel() -> Float { filter.getMinimumOutputGreenLevel() }
    func resetMinimumOutputGreenLevel() { filter.resetMinimumOutputGreenLevel() }

    func setMaximumOutputGreenLevel(_ value: Float) {
        filter.setMaximumOutputGreenLevel(value)
        updateOutputImage()
    }
    func getMaximumOutputGreenLevel() -> Float { filter.getMaximumOutputGreenLevel() }
    func resetMaximumOutputGreenLevel() { filter.resetMaximumOutputGreenLevel() }

    func setMinimumBlueLevel(_ value: Float) {
        filter.setMinimumBlueLevel(value)
        updateOutputImage()
    }
    func getMinimumBlueLevel() -> Float { filter.getMinimumBlueLevel() }
    func resetMinimumBlueLevel() { filter.resetMinimumBlueLevel() }

    func setMiddleBlueLevel(_ value: Float) {
        filter.setMiddleBlueLevel(value)
        updateOutputImage()
    }
    func getMiddleBlueLevel() -> Float { filter.getMiddleBlueLevel() }
    func resetMiddleBlueLevel() { filter.resetMiddleBlueLevel() }

    func setMaximumBlueLevel(_ value: Float) {
        filter.setMaximumBlueLevel(value)
        updateOutputImage()
    }
    func getMaximumBlueLevel() -> Float { filter.getMaximumBlueLevel() }
    func resetMaximumBlueLevel() { filter.resetMaximumBlueLevel() }

    func setMinimumOutputBlueLevel(_ value: Float) {
        filter.setMinimumOutputBlueLevel(value)
        updateOutputImage()
    }
    func getMinimumOutputBlueLevel() -> Float { filter.getMinimumOutputBlueLevel() }
    func resetMinimumOutputBlueLevel() { filter.resetMinimumOutputBlueLevel() }

    func setMaximumOutputBlueLevel(_ value: Float) {
        filter.setMaximumOutputBlueLevel(value)
        updateOutputImage()
    }
    func getMaximumOutputBlueLevel() -> Float { filter.getMaximumOutputBlueLevel() }
    func resetMaximumOutputBlueLevel() { filter.resetMaximumOutputBlueLevel() }

    func setGrainAmount(_ value: Float) {
        filter.setGrainAmount(value)
        updateOutputImage()
    }
    func getGrainAmount() -> Float { filter.getGrainAmount() }
    func resetGrainAmount() { filter.resetGrainAmount() }

    func showOriginalImage() { outputImage = originalImage }
    func showFilteredImage() { updateOutputImage() }
    private func updateOutputImage() { outputImage = filter.filterImage(image: originalImage) }

    func changeOriginalImage(with image: UIImage?, orientation: UIImage.Orientation?) {
        if let image = image {
            let imageToSet = MTIImage(image: image).unpremultiplyingAlpha()
            if let orientation = orientation {
                imageToSet.oriented(orientation.cgImagePropertyOrientation)
            }
            originalImage = imageToSet
            updateOutputImage()
        }
    }


}
