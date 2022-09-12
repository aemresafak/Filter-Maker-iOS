//
//  FilterEditView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import SwiftUI

struct FilterEditView: View {

    @Binding var anofilmFilter: AnofilmFilter
    @StateObject private var filterEditViewModel = FilterEditViewModel()
    @State private var showFiltersSheet = false
    @State private var showImagePickerSheet = false
    @State private var showSaveDialog = false
    @State private var showPhotoLibraryAdditionPermissionDeniedDialog = false
    @State private var showSavedToDocumentsToastMessage = false
    @State private var imageChosen: UIImage?
    @EnvironmentObject var filtersViewModel: FiltersViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    FilterImageView(imageToDisplay: $filterEditViewModel.outputImage)
                    editContent.frame(
                        width: geometry.size.width,
                        height: geometry.size.height * 0.3,
                        alignment: .center
                    )
                }
                CustomizableDialog(showDialog: $showSaveDialog, content: createSaveDialogContent)
                CustomizableDialog(showDialog: $showPhotoLibraryAdditionPermissionDeniedDialog, content: createPhotoLibraryAdditionPermissionDeniedDialogContent)
                ToastMessage(showMessage: $showSavedToDocumentsToastMessage) {
                    toastContent
                }
            }

        }
            .onAppear(perform: {
            filterEditViewModel.updateAnofilmFilter(filter: anofilmFilter)
        })
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
        case .vignette:
            editVignetteView
        case .rgbAdjustment:
            editRGBAdjustmentView
        }
    }

    private var toastContent: some View {
        Text("Image saved to gallery!")
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
        )
            .font(.largeTitle)
            .shadow(radius: 8)
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


    private var editVignetteView: some View {
        ScrollView {
            createEditViewWithSlider(
                editName: "Vignette Center X",
                value: Binding(get: { filterEditViewModel.getVignetteCenterX() }, set: { filterEditViewModel.setVignetteCenterX($0) }),
                range: 0...1,
                resetValue: 0.5
            )
            createEditViewWithSlider(
                editName: "Vignette Center Y",
                value: Binding(get: { filterEditViewModel.getVignetteCenterY() }, set: { filterEditViewModel.setVignetteCenterY($0) }),
                range: 0...1,
                resetValue: 0.5
            )
            createEditViewWithSlider(
                editName: "Vignette Start",
                value: Binding(get: { filterEditViewModel.getVignetteStart() }, set: { filterEditViewModel.setVignetteStart($0) }),
                range: 0...1,
                resetValue: 0.5
            )
            createEditViewWithSlider(
                editName: "Vignette End",
                value: Binding(get: { filterEditViewModel.getVignetteEnd() }, set: { filterEditViewModel.setVignetteEnd($0) }),
                range: 0...1,
                resetValue: 0.75
            )
            ColorPicker(
                "Pick Vignette Color",
                selection: Binding(get: { filterEditViewModel.getVignetteColor() }, set: { filterEditViewModel.setVignetteColor($0) })
            )

        }.padding()
    }

    private var editRGBAdjustmentView: some View {
            ScrollView {
                createHorizontalSliderWithColor(color: Color.red, value: Binding(get: { filterEditViewModel.getRedAdjustment() }, set: { filterEditViewModel.setRedAdjustment($0) }))
                createHorizontalSliderWithColor(color: Color.green, value: Binding(get: { filterEditViewModel.getGreenAdjustment() }, set: { filterEditViewModel.setGreenAdjustment($0) }))
                createHorizontalSliderWithColor(color: Color.blue, value: Binding(get: { filterEditViewModel.getBlueAdjustment() }, set: { filterEditViewModel.setBlueAdjustment($0) }))
            }
        
    }

    private func createHorizontalSliderWithColor(color: Color, value: Binding<Float>) -> some View {
        HStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 32, height: 32)
                .padding(.trailing)
            Slider(value: value, in: 0...1)
            Button {
                value.wrappedValue = 1
            } label: {
                Image(systemName: "arrow.uturn.backward")
            }.padding(.leading)
        }
            .padding()
    }

    private func createToolbarContent() -> some View {
        HStack {
            Button {
                let permissionManager = PhotosLibraryPermissionManager {
                    filterEditViewModel.saveImageToDocuments {
                        withAnimation {
                            showSavedToDocumentsToastMessage = true
                        }
                    }
                } onDenied: {
                    showPhotoLibraryAdditionPermissionDeniedDialog = true
                }
                permissionManager.requestPhotosLibraryAdditionPermission()
            } label: {
                Image(systemName: "square.and.arrow.down.on.square.fill")
            }

            Button {
                showSaveDialog = true
            } label: {
                Image(systemName: "square.and.arrow.down")
            }

            Button {
                showImagePickerSheet = true
            } label: {
                Image(systemName: "photo")
            }
            Button {
                showFiltersSheet = true
            } label: {
                Image(systemName: "camera.filters")
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
            List(EditType.allCases) { editType in
                Button {
                    filterEditViewModel.editType = editType
                    showFiltersSheet = false
                } label: {
                    Text(editType.rawValue.capitalized)
                }

            }
        }
    }

    @ViewBuilder private func createPhotoLibraryAdditionPermissionDeniedDialogContent() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
            VStack {
                Text("You denied permission to save photos to your library.")
                Text("You need to go to settings to enable it.")
                Link("Open settings", destination: URL(string: UIApplication.openSettingsURLString)!)
                    .padding()
            }.padding()
        }.frame(width: 250, height: 300, alignment: .center)
    }

    @ViewBuilder private func createSaveDialogContent() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(colorScheme == .light ? .white : .black)
            VStack {
                Text("Save your filter")
                TextField(
                    "Filter Name",
                    text: Binding(get: { filterEditViewModel.getFilterName() }, set: { filterEditViewModel.setFilterName($0) })
                )
                Spacer()
                HStack {
                    Button {
                        showSaveDialog = false
                    } label: {
                        Text("Cancel")
                    }
                    Spacer()
                    Button {
                        showSaveDialog = false
                        anofilmFilter = filterEditViewModel.getFilter()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }.padding()
        }.frame(width: 250, height: 300, alignment: .center)
    }

    private func createImagePicker() -> some View {
        ImagePicker(uiImage: $imageChosen)
    }





}
