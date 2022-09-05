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
                range: -1...1,
                resetValue: 0,
                onChange: { newValue in
                    filterEditViewModel.setBrightness(newValue)
                }
            )
        case .contrast:
            createEditViewWithSlider(
                editName: "contrast",
                value: Binding(get: { filterEditViewModel.getContrast() }, set: { filterEditViewModel.setContrast($0) }),
                range: 0...2,
                resetValue: 1) { newValue in
                filterEditViewModel.setContrast(newValue)
            }
        }
    }

    private func createEditViewWithSlider(
        editName: String,
        value: Binding<Float>,
        range: ClosedRange<Float>,
        resetValue: Float,
        onChange: @escaping (Float) -> Void
    ) -> some View {
        VStack {
            HStack {
                Text("\(editName): \(value.wrappedValue, specifier: "%.2f")")
                Spacer()
                Button(action: { value.wrappedValue = resetValue }) {
                    Image(systemName: "arrow.uturn.backward")
                }
            }
            Slider(value: value, in: range)
                .onChange(of: value.wrappedValue, perform: onChange)
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
