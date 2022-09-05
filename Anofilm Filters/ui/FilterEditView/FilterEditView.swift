//
//  FilterEditView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import SwiftUI

struct FilterEditView: View {

    @StateObject private var filterEditViewModel = FilterEditViewModel()

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

    }



    @ViewBuilder private var editContent: some View {
        switch filterEditViewModel.editType {
        case .brightness:
            adjustBrightnessView
        default:
            Text("default")
        }
    }


    @State private var brightness: Float = 0
    private var adjustBrightnessView: some View {
        VStack {
            HStack {
                Text("Brightness: \(filterEditViewModel.getBrightness())")
                Spacer()
                Button(action: { brightness = 0 }) {
                    Image(systemName: "arrow.uturn.backward")
                }
            }
            Slider(value: $brightness, in: -1...1)
                .onChange(of: brightness) { newValue in
                    filterEditViewModel.setBrightness(newValue)
                }
        }.padding()


    }

    private var toolbarContent: some View {
        Text("dummy")
    }


}

struct FilterEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FilterEditView()
        }
    }
}
