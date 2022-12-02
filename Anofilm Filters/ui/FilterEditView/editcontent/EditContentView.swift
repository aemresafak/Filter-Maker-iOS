//
//  EditContentView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 17.09.2022.
//

import SwiftUI

struct EditContentView: View {
    @ObservedObject var filterEditViewModel: FilterEditViewModel

    var body: some View {
        editContent
    }

    @ViewBuilder private var editContent: some View {
        switch filterEditViewModel.editType {
        case .brightness:
            editBrightnessView
        case .contrast:
            editContrastView
        case .saturation:
            editSaturationView
        case .exposure:
            editExposureView
        case .vibrance:
            editVibranceView
        case .whiteBalance:
            editWhiteBalanceView
        case .gamma:
            editGammaView
        case .haze:
            editHazeView
        case .highlightsAndShadows:
            editHighlightsAndShadowsView
        case .sepiaTone:
            editSepiaToneView
        case .tint:
            editTintView
        case .highlightTint:
            editHighlightTintView
        case .shadowTint:
            editShadowTintView
        case .vignette:
            editVignetteView
        case .secondaryVignette:
            editSecondaryVignetteView
        case .rgbAdjustment:
            editRGBAdjustmentView
        case .clahe:
            editClaheView
        case .rgbLevelsAdjustment:
            editRGBLevelsAdjustmentView
        case .redLevelsAdjustment:
            editRedLevelsAdjustmentView
        case .greenLevelsAdjustment:
            editGreenLevelsAdjustmentView
        case .blueLevelsAdjustment:
            editBlueLevelsAdjustmentView
        case .grain:
            editGrainView
        case .infrared:
            editInfraredFilterView
        }
    }






    private var editBrightnessView: some View {
        SliderEditView(
            editName: "Brightness",
            value: Binding(get: { filterEditViewModel.getBrightness() }, set: { filterEditViewModel.setBrightness($0) }),
            range: -1...1
        )
    }

    private var editContrastView: some View {
        SliderEditView(
            editName: "Contrast",
            value: Binding(get: { filterEditViewModel.getContrast() }, set: { filterEditViewModel.setContrast($0) }),
            range: 0...2
        )
    }

    private var editSaturationView: some View {
        SliderEditView(
            editName: "Saturation",
            value: Binding(get: { filterEditViewModel.getSaturation() }, set: { filterEditViewModel.setSaturation($0) }),
            range: 0...2
        )
    }
    private var editExposureView: some View {
        SliderEditView(
            editName: "Exposure",
            value: Binding(get: { filterEditViewModel.getExposure() }, set: { filterEditViewModel.setExposure($0) }),
            range: -0.45...0.45
        )
    }

    private var editVibranceView: some View {
        SliderEditView(
            editName: "Vibrance",
            value: Binding(get: { filterEditViewModel.getVibrance() }, set: { filterEditViewModel.setVibrance($0) }),
            range: -1...1
        )
    }

    private var editGammaView: some View {
        SliderEditView(
            editName: "Gamma",
            value: Binding(get: { filterEditViewModel.getGamma() }, set: { filterEditViewModel.setGamma($0) }),
            range: 0...3,
            resetValue: 1
        )
    }

    private var editWhiteBalanceView: some View {
        VStack {
            SliderEditView(
                editName: "Temperature",
                value: Binding(get: { filterEditViewModel.getWhiteBalanceTemperature() }, set: { filterEditViewModel.setWhiteBalanceTemperature($0) }),
                range: -1...1
            )
            SliderEditView(
                editName: "Hue",
                value: Binding(get: { filterEditViewModel.getWhiteBalanceHue() }, set: { filterEditViewModel.setWhiteBalanceHue($0) }),
                range: -1...1
            )
        }.padding()
    }

    private var editHazeView: some View {
        VStack {
            SliderEditView(
                editName: "Haze Distance",
                value: Binding(get: { filterEditViewModel.getHazeDistance() }, set: { filterEditViewModel.setHazeDistance($0) }),
                range: -3...3
            )
            SliderEditView(
                editName: "Haze slope",
                value: Binding(get: { filterEditViewModel.getHazeSlope() }, set: { filterEditViewModel.setHazeSlope($0) }),
                range: -3...3
            )
        }.padding()
    }

    private var editHighlightsAndShadowsView: some View {
        VStack {
            SliderEditView(
                editName: "Highlights",
                value: Binding(get: { filterEditViewModel.getHighlights() }, set: { filterEditViewModel.setHighlights($0) }),
                range: 0...1,
                resetValue: 1
            )
            SliderEditView(
                editName: "Shadows",
                value: Binding(get: { filterEditViewModel.getShadows() }, set: { filterEditViewModel.setShadows($0) }),
                range: 0...1,
                resetValue: 0
            )
        }
    }

    private var editSepiaToneView: some View {
        SliderEditView(
            editName: "Sepia Tone",
            value: Binding(get: { filterEditViewModel.getSepiaTone() }, set: { filterEditViewModel.setSepiaTone($0) }),
            range: 0...1,
            resetValue: 0
        )
    }

    private var editTintView: some View {
        VStack {
            ColorPicker(
                "Pick color for Tint",
                selection: $filterEditViewModel.tintColor
            )
            SliderEditView(
                editName: "Tint Intensity",
                value: Binding(get: { filterEditViewModel.getTintIntensity() }, set: { filterEditViewModel.setTintIntensity($0) }),
                range: 0...1,
                resetValue: 0
            )
        }.padding()
    }

    private var editHighlightTintView: some View {
        let k = print("ahmet emre")
        VStack {
            ColorPicker(
                "Pick color for Highlight Tint",
                selection: $filterEditViewModel.highlightTintColor
            )
            SliderEditView(
                editName: "Highlight Tint Intensity",
                value: Binding(get: { filterEditViewModel.getHighlightTintIntensity() }, set: { filterEditViewModel.setHighlightTintIntensity($0) }),
                range: 0...1,
                resetValue: 0
            )
        }.padding()
    }

    private var editShadowTintView: some View {
        VStack {
            ColorPicker(
                "Pick color for Shadow Tint",
                selection: $filterEditViewModel.shadowTintColor
            )
            SliderEditView(
                editName: "Shadow Tint Intensity",
                value: Binding(get: { filterEditViewModel.getShadowTintIntensity() }, set: { filterEditViewModel.setShadowTintIntensity($0) }),
                range: 0...1,
                resetValue: 0
            )
        }.padding()
    }


    private var editVignetteView: some View {
        ScrollView {
            SliderEditView(
                editName: "Vignette Center X",
                value: Binding(get: { filterEditViewModel.getVignetteCenterX() }, set: { filterEditViewModel.setVignetteCenterX($0) }),
                range: 0...1,
                resetValue: 0.5
            )
            SliderEditView(
                editName: "Vignette Center Y",
                value: Binding(get: { filterEditViewModel.getVignetteCenterY() }, set: { filterEditViewModel.setVignetteCenterY($0) }),
                range: 0...1,
                resetValue: 0.5
            )
            SliderEditView(
                editName: "Vignette Start",
                value: Binding(get: { filterEditViewModel.getVignetteStart() }, set: { filterEditViewModel.setVignetteStart($0) }),
                range: 0...1,
                resetValue: 0.5
            )
            SliderEditView(
                editName: "Vignette End",
                value: Binding(get: { filterEditViewModel.getVignetteEnd() }, set: { filterEditViewModel.setVignetteEnd($0) }),
                range: 0...1,
                resetValue: 0.75
            )
            ColorPicker(
                "Pick Vignette Color",
                selection: $filterEditViewModel.vignetteColor
            )

        }.padding()
    }

    private var editSecondaryVignetteView: some View {
        ScrollView {
            SliderEditView(
                editName: "Secondary Vignette Center X",
                value: Binding(get: { filterEditViewModel.getSecondaryVignetteCenterX() }, set: { filterEditViewModel.setSecondaryVignetteCenterX($0) }),
                range: 0...1,
                resetValue: 0.5
            )
            SliderEditView(
                editName: "Secondary Vignette Center Y",
                value: Binding(get: { filterEditViewModel.getSecondaryVignetteCenterY() }, set: { filterEditViewModel.setSecondaryVignetteCenterY($0) }),
                range: 0...1,
                resetValue: 0.5
            )
            SliderEditView(
                editName: "Secondary Vignette Start",
                value: Binding(get: { filterEditViewModel.getSecondaryVignetteStart() }, set: { filterEditViewModel.setSecondaryVignetteStart($0) }),
                range: 0...1,
                resetValue: 0.5
            )
            SliderEditView(
                editName: "Secondary Vignette End",
                value: Binding(get: { filterEditViewModel.getSecondaryVignetteEnd() }, set: { filterEditViewModel.setSecondaryVignetteEnd($0) }),
                range: 0...1,
                resetValue: 0.75
            )
            ColorPicker(
                "Pick SecondaryVignette Color",
                selection: $filterEditViewModel.secondaryVignetteColor
            )

        }.padding()
    }

    private var editRGBAdjustmentView: some View {
        ScrollView {
            ColorSliderView(color: Color.red, value: Binding(get: { filterEditViewModel.getRedAdjustment() }, set: { filterEditViewModel.setRedAdjustment($0) }))
            ColorSliderView(color: Color.green, value: Binding(get: { filterEditViewModel.getGreenAdjustment() }, set: { filterEditViewModel.setGreenAdjustment($0) }))
            ColorSliderView(color: Color.blue, value: Binding(get: { filterEditViewModel.getBlueAdjustment() }, set: { filterEditViewModel.setBlueAdjustment($0) }))
        }
    }

    private var editClaheView: some View {
        ScrollView {
            SliderEditView(
                editName: "Clip Limit",
                value: Binding(get: { filterEditViewModel.getClaheClipLimit() }, set: { filterEditViewModel.setClaheClipLimit($0) }),
                range: 0...2,
                resetValue: 0
            )
            EditStepperView(
                title: "Tile Width",
                value: Binding(get: { filterEditViewModel.getClaheTileWidth() }, set: { filterEditViewModel.setClaheTileWidth($0) }),
                range: 1...32,
                resetValue: 8
            )
            EditStepperView(
                title: "Tile Height",
                value: Binding(get: { filterEditViewModel.getClaheTileHeight() }, set: { filterEditViewModel.setClaheTileHeight($0) }),
                range: 1...32,
                resetValue: 8
            )

        }
    }

    private var editRGBLevelsAdjustmentView: some View { LevelsAdjustmentView(
            minimumLevel: Binding(get: { filterEditViewModel.getMinimumRGBLevel() }, set: { filterEditViewModel.setMinimumRGBLevel($0) }),
            middleLevel: Binding(get: { filterEditViewModel.getMiddleRGBLevel() }, set: { filterEditViewModel.setMiddleRGBLevel($0) }),
            maximumLevel: Binding(get: { filterEditViewModel.getMaximumRGBLevel() }, set: { filterEditViewModel.setMaximumRGBLevel($0) }),
            minimumOutputLevel: Binding(get: { filterEditViewModel.getMinimumOutputRGBLevel() }, set: { filterEditViewModel.setMinimumOutputRGBLevel($0) }),
            maximumOutputLevel: Binding(get: { filterEditViewModel.getMaximumOutputRGBLevel() }, set: { filterEditViewModel.setMaximumOutputRGBLevel($0) })
        )
    }

    private var editRedLevelsAdjustmentView: some View {
        LevelsAdjustmentView(
            minimumLevel: Binding(get: { filterEditViewModel.getMinimumRedLevel() }, set: { filterEditViewModel.setMinimumRedLevel($0) }),
            middleLevel: Binding(get: { filterEditViewModel.getMiddleRedLevel() }, set: { filterEditViewModel.setMiddleRedLevel($0) }),
            maximumLevel: Binding(get: { filterEditViewModel.getMaximumRedLevel() }, set: { filterEditViewModel.setMaximumRedLevel($0) }),
            minimumOutputLevel: Binding(get: { filterEditViewModel.getMinimumOutputRedLevel() }, set: { filterEditViewModel.setMinimumOutputRedLevel($0) }),
            maximumOutputLevel: Binding(get: { filterEditViewModel.getMaximumOutputRedLevel() }, set: { filterEditViewModel.setMaximumOutputRedLevel($0) })
        )
    }


    private var editGreenLevelsAdjustmentView: some View {
        LevelsAdjustmentView(
            minimumLevel: Binding(get: { filterEditViewModel.getMinimumGreenLevel() }, set: { filterEditViewModel.setMinimumGreenLevel($0) }),
            middleLevel: Binding(get: { filterEditViewModel.getMiddleGreenLevel() }, set: { filterEditViewModel.setMiddleGreenLevel($0) }),
            maximumLevel: Binding(get: { filterEditViewModel.getMaximumGreenLevel() }, set: { filterEditViewModel.setMaximumGreenLevel($0) }),
            minimumOutputLevel: Binding(get: { filterEditViewModel.getMinimumOutputGreenLevel() }, set: { filterEditViewModel.setMinimumOutputGreenLevel($0) }),
            maximumOutputLevel: Binding(get: { filterEditViewModel.getMaximumOutputGreenLevel() }, set: { filterEditViewModel.setMaximumOutputGreenLevel($0) })
        )
    }

    private var editBlueLevelsAdjustmentView: some View {
        LevelsAdjustmentView(
            minimumLevel: Binding(get: { filterEditViewModel.getMinimumBlueLevel() }, set: { filterEditViewModel.setMinimumBlueLevel($0) }),
            middleLevel: Binding(get: { filterEditViewModel.getMiddleBlueLevel() }, set: { filterEditViewModel.setMiddleBlueLevel($0) }),
            maximumLevel: Binding(get: { filterEditViewModel.getMaximumBlueLevel() }, set: { filterEditViewModel.setMaximumBlueLevel($0) }),
            minimumOutputLevel: Binding(get: { filterEditViewModel.getMinimumOutputBlueLevel() }, set: { filterEditViewModel.setMinimumOutputBlueLevel($0) }),
            maximumOutputLevel: Binding(get: { filterEditViewModel.getMaximumOutputBlueLevel() }, set: { filterEditViewModel.setMaximumOutputBlueLevel($0) })
        )
    }

    private var editGrainView: some View {
        SliderEditView(editName: "Grain", value: Binding(get: { filterEditViewModel.getGrainAmount() }, set: { filterEditViewModel.setGrainAmount($0) }), range: 0...100, resetValue: 0)
    }

    private var editInfraredFilterView: some View {
        VStack {
            Text(filterEditViewModel.applyInfrared == true ? "Infrared is applied." : "Infrared is not applied.")
            Button {
                filterEditViewModel.applyInfrared.toggle()
            } label: {
                Text(filterEditViewModel.applyInfrared == true ? "Disable Infrared Filter" : "Enable Infrared Filter")
            }

        }
    }
}

struct EditContentView_Previews: PreviewProvider {
    @StateObject static private var viewModel = FilterEditViewModel()
    static var previews: some View {
        EditContentView(filterEditViewModel: viewModel)
    }
}
