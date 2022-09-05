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
            Text("Brightness")
        default:
            Text("default")
        }
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
