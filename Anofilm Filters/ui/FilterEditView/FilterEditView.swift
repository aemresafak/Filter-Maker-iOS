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


    var body: some View {
        GeometryReader { geometry in
            VStack {
                FilterImageView(imageToDisplay: $filterEditViewModel.outputImage)
                editContent.frame(
                    width: geometry.size.width,
                    height: geometry.size.height * 0.2,
                    alignment: .center
                )
            }
        }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: createToolbarContent)
            .sheet(isPresented: $showFiltersSheet, onDismiss: nil, content: createFiltersList)

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
        }
    }

    private func createEditViewWithSlider(
        editName: String,
        value: Binding<Float>,
        range: ClosedRange<Float>
    ) -> some View {
        VStack {
            HStack {
                Text("\(editName): \(value.wrappedValue, specifier: "%.2f")")
                Spacer()
                Button(action: { value.wrappedValue = (range.lowerBound + range.upperBound) / 2 }) {
                    Image(systemName: "arrow.uturn.backward")
                }
            }
            Slider(value: value, in: range)
        }.padding()

    }


    private func createToolbarContent() -> some View {
        HStack {
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



}

struct FilterEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FilterEditView()
        }
    }
}
