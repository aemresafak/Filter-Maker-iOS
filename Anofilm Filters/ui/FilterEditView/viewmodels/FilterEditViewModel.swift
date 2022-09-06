//
//  FilterEditViewModel.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import Foundation
import MetalPetal
import UIKit


class FilterEditViewModel: ObservableObject {

    private var filter = AnofilmFilter()
    private var originalImage: MTIImage? = MTIImage(cgImage: UIImage(named: "sampleImage")!.cgImage!).unpremultiplyingAlpha()
    @Published var outputImage: MTIImage?
    @Published var editType = EditType.brightness

    init() {
        outputImage = self.originalImage
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






    private func updateOutputImage() {
        outputImage = filter.filterImage(image: originalImage)
    }

    func changeOriginalImage(with image: UIImage?) {
        if let image = image, let cgImage = image.cgImage {
            originalImage = MTIImage(cgImage: cgImage).unpremultiplyingAlpha()
            updateOutputImage()
        }
    }


}
