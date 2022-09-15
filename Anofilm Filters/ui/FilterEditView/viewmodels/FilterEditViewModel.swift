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

    @Binding var filter: AnofilmFilter
    private var originalImage: MTIImage? = MTIImage(cgImage: UIImage(named: "sampleImage")!.cgImage!).unpremultiplyingAlpha()
    private let context: MTIContext? = try? MTIContext(device: MTLCreateSystemDefaultDevice()!)
    
    @Published var outputImage: MTIImage?
    @Published var editType = EditType.brightness
    
    var newFilterName: String


    init(filter: Binding<AnofilmFilter>) {
        outputImage = self.originalImage
        self._filter = filter
        newFilterName = filter.wrappedValue.name
        updateOutputImage()
    }
    
    func changeOriginalImage(with image: UIImage?) {
        if let image = image, let cgImage = image.cgImage {
            originalImage = MTIImage(cgImage: cgImage).unpremultiplyingAlpha()
            originalImage?.oriented(image.imageOrientation.cgImagePropertyOrientation)
            updateOutputImage()
        }
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
    
    func setMinimumLevelColor(_ color: Color) {
        filter.setMinimumLevel(color)
        updateOutputImage()
    }
    func getMinimumLevelColor() -> Color { filter.getMinimumLevel() }
    func resetMinimumLevelColor() { filter.resetMinimumLevel() }
    
    func setMiddleLevelColor(_ color: Color) {
        filter.setMiddleLevel(color)
        updateOutputImage()
    }
    func getMiddleLevelColor() -> Color { filter.getMiddleLevel() }
    func resetMiddleLevelColor() { filter.resetMiddleLevel() }
    
    func setMaximumLevelColor(_ color: Color) {
        filter.setMaximumLevel(color)
        updateOutputImage()
    }
    func getMaximumLevelColor() -> Color { filter.getMaximumLevel() }
    func resetMaximumLevelColor()  { filter.resetMaximumLevel() }
    
    func setMinimumOutputLevelColor(_ color: Color) {
        filter.setMinimumOutputLevel(color)
        updateOutputImage()
    }
    func getMinimumOutputLevelColor() -> Color { filter.getMinimumOutputLevel() }
    func resetMinimumOutputLevelColor() { filter.resetMinimumOutputLevel() }
    
    func setMaximumOutputLevelColor(_ color: Color) {
        filter.setMaximumOutputLevel(color)
        updateOutputImage()
    }
    func getMaximumOutputLevelColor() -> Color { filter.getMaximumOutputLevel() }
    func resetMaximumOutputLevelColor() { filter.resetMaximumOutputLevel() }
    
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
    
    
    private func updateOutputImage() {
        outputImage = filter.filterImage(image: originalImage)
    }



}
