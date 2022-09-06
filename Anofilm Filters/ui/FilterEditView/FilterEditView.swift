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
            createEditViewWithSlider(
                editName: "Brightness",
                value: Binding(get: { filterEditViewModel.getBrightness() }, set: { filterEditViewModel.setBrightness($0) }),
                range: -1...1
            )
        case .contrast:
            createEditViewWithSlider(
                editName: "Contrast",
                value: Binding(get: { filterEditViewModel.getContrast() }, set: { filterEditViewModel.setContrast($0) }),
                range: 0...2
            )
        case .saturation:
            createEditViewWithSlider(
                editName: "Saturation",
                value: Binding(get: { filterEditViewModel.getSaturation() }, set: { filterEditViewModel.setSaturation($0) }),
                range: 0...2
            )
        case .exposure:
            createEditViewWithSlider(
                editName: "Exposure",
                value: Binding(get: { filterEditViewModel.getExposure() }, set: { filterEditViewModel.setExposure($0) }),
                range: -0.45...0.45
            )
        case .vibrance:
            createEditViewWithSlider(
                editName: "Vibrance",
                value: Binding(get: { filterEditViewModel.getVibrance() }, set: { filterEditViewModel.setVibrance($0) }),
                range: -1...1
            )
        case .whiteBalance:
            editWhiteBalanceView
        case .gamma:
            createEditViewWithSlider(
                editName: "Gamma",
                value: Binding(get: { filterEditViewModel.getGamma() }, set: { filterEditViewModel.setGamma($0) }),
                range: 0...3,
                resetValue: 1
            )
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

    private var editWhiteBalanceView: some View {
        VStack {
            HStack {
                Text("Temperature: \(filterEditViewModel.getWhiteBalanceTemperature())")
                Spacer()
                Button {
                    filterEditViewModel.resetWhiteBalanceTemperature()
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                }
            }
            Slider(value: Binding(get: { filterEditViewModel.getWhiteBalanceTemperature() }, set: { filterEditViewModel.setWhiteBalanceTemperature($0) }), in: -1...1)
            HStack {
                Text("Hue: \(filterEditViewModel.getWhiteBalanceHue())")
                Spacer()
                Button {
                    filterEditViewModel.resetWhiteBalanceHue()
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                }
            }
            Slider(value: Binding(get: { filterEditViewModel.getWhiteBalanceHue() }, set: { filterEditViewModel.setWhiteBalanceHue($0) }), in: -1...1)
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
