//
//  FilterEditView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import SwiftUI

struct FilterEditView: View {

    @StateObject private var filterEditViewModel = FilterEditViewModel()
    @State private var showFiltersSheet = false
    @State private var showImagePickerSheet = false
    @State private var imageChosen: UIImage?


    var body: some View {
        GeometryReader { geometry in
            VStack {
                FilterImageView(imageToDisplay: $filterEditViewModel.outputImage)
                editContent.frame(
                    width: geometry.size.width,
                    height: geometry.size.height * 0.3,
                    alignment: .center
                )
            }
        }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: createToolbarContent)
            .sheet(isPresented: $showFiltersSheet, onDismiss: nil, content: createFiltersList)
            .sheet(isPresented: $showImagePickerSheet, onDismiss: nil, content: createImagePicker)
            .onChange(of: imageChosen, perform: {
            filterEditViewModel.changeOriginalImage(with: $0)
        })

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
        }
    }

    private func createEditViewWithSlider(
        editName: String,
        value: Binding<Float>,
        range: ClosedRange<Float>,
        resetValue: Float? = nil
    ) -> some View {
        VStack {
            HStack {
                Text("\(editName): \(value.wrappedValue, specifier: "%.2f")")
                Spacer()
                Button(action: { value.wrappedValue = resetValue == nil ? (range.lowerBound + range.upperBound) / 2 : resetValue! }) {
                    Image(systemName: "arrow.uturn.backward")
                }
            }
            Slider(value: value, in: range)
        }.padding()

    }







    private var editBrightnessView: some View {
        createEditViewWithSlider(
            editName: "Brightness",
            value: Binding(get: { filterEditViewModel.getBrightness() }, set: { filterEditViewModel.setBrightness($0) }),
            range: -1...1
        )
    }

    private var editContrastView: some View {
        createEditViewWithSlider(
            editName: "Contrast",
            value: Binding(get: { filterEditViewModel.getContrast() }, set: { filterEditViewModel.setContrast($0) }),
            range: 0...2
        )
    }

    private var editSaturationView: some View {
        createEditViewWithSlider(
            editName: "Saturation",
            value: Binding(get: { filterEditViewModel.getSaturation() }, set: { filterEditViewModel.setSaturation($0) }),
            range: 0...2
        )
    }
    private var editExposureView: some View {
        createEditViewWithSlider(
            editName: "Exposure",
            value: Binding(get: { filterEditViewModel.getExposure() }, set: { filterEditViewModel.setExposure($0) }),
            range: -0.45...0.45
        )
    }

    private var editVibranceView: some View {
        createEditViewWithSlider(
            editName: "Vibrance",
            value: Binding(get: { filterEditViewModel.getVibrance() }, set: { filterEditViewModel.setVibrance($0) }),
            range: -1...1
        )
    }

    private var editGammaView: some View {
        createEditViewWithSlider(
            editName: "Gamma",
            value: Binding(get: { filterEditViewModel.getGamma() }, set: { filterEditViewModel.setGamma($0) }),
            range: 0...3,
            resetValue: 1
        )
    }

    private var editWhiteBalanceView: some View {
        VStack {
            createEditViewWithSlider(
                editName: "Temperature",
                value: Binding(get: { filterEditViewModel.getWhiteBalanceTemperature() }, set: { filterEditViewModel.setWhiteBalanceTemperature($0) }),
                range: -1...1
            )
            createEditViewWithSlider(
                editName: "Hue",
                value: Binding(get: { filterEditViewModel.getWhiteBalanceHue() }, set: { filterEditViewModel.setWhiteBalanceHue($0) }),
                range: -1...1
            )
        }.padding()
    }

    private var editHazeView: some View {
        VStack {
            createEditViewWithSlider(
                editName: "Haze Distance",
                value: Binding(get: { filterEditViewModel.getHazeDistance() }, set: { filterEditViewModel.setHazeDistance($0) }),
                range: -3...3
            )
            createEditViewWithSlider(
                editName: "Haze slope",
                value: Binding(get: { filterEditViewModel.getHazeSlope() }, set: { filterEditViewModel.setHazeSlope($0) }),
                range: -3...3
            )
        }.padding()
    }

    private var editHighlightsAndShadowsView: some View {
        VStack {
            createEditViewWithSlider(
                editName: "Highlights",
                value: Binding(get: { filterEditViewModel.getHighlights() }, set: { filterEditViewModel.setHighlights($0) }),
                range: 0...1,
                resetValue: 1
            )
            createEditViewWithSlider(
                editName: "Shadows",
                value: Binding(get: { filterEditViewModel.getShadows() }, set: { filterEditViewModel.setShadows($0) }),
                range: 0...1,
                resetValue: 0
            )
        }
    }

    private var editSepiaToneView: some View {
        createEditViewWithSlider(
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
                    selection: Binding(get: { filterEditViewModel.getTintColor() }, set: { filterEditViewModel.setTintColor($0) })
                )
            createEditViewWithSlider(
                editName: "Tint Intensity",
                value: Binding(get: { filterEditViewModel.getTintIntensity() }, set: { filterEditViewModel.setTintIntensity($0) }),
                range: 0...1,
                resetValue: 0
            )
        }.padding()
    }
    
    private var editHighlightTintView: some View {
        VStack {
                ColorPicker(
                    "Pick color for Highlight Tint",
                    selection: Binding(get: { filterEditViewModel.getHighlightTintColor() }, set: { filterEditViewModel.setHighlightTintColor($0) })
                )
            createEditViewWithSlider(
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
                    selection: Binding(get: { filterEditViewModel.getShadowTintColor() }, set: { filterEditViewModel.setShadowTintColor($0) })
                )
            createEditViewWithSlider(
                editName: "Shadow Tint Intensity",
                value: Binding(get: { filterEditViewModel.getShadowTintIntensity() }, set: { filterEditViewModel.setShadowTintIntensity($0) }),
                range: 0...1,
                resetValue: 0
            )
        }.padding()
    }



    private func createToolbarContent() -> some View {
        HStack {
            Button {
                showFiltersSheet = true
            } label: {
                Image(systemName: "camera.filters")
            }
            Button {
                showImagePickerSheet = true
            } label: {
                Image(systemName: "photo")
            }

        }
    }

    private func createFiltersList() -> some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    showFiltersSheet = false
                }
            }
                .padding()
            Spacer()
            Picker("Choose a Filter", selection: $filterEditViewModel.editType) {
                ForEach(EditType.allCases) { editType in
                    Text(editType.rawValue.capitalized)
                }
            }
                .pickerStyle(.wheel)
                .padding()
            Spacer()
        }
    }

    private func createImagePicker() -> some View {
        ImagePicker(uiImage: $imageChosen)
    }

 



}

struct FilterEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FilterEditView()
        }
    }
}
