//
//  FiltersView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import SwiftUI

struct FiltersView: View {

    @EnvironmentObject var filtersViewModel: FiltersViewModel
    var body: some View {
        filtersView
            .toolbar(content: createToolbar)
            .navigationTitle("Filters")

    }

    private var filtersView: some View {
        GeometryReader { reader in
            ScrollView {
                ForEach(filtersViewModel.filters) { filter in
                    NavigationLink {
                        EmptyView()
                    } label: {
                        FilterItem(anofilmFilter: filter)
                            .frame(maxWidth: .infinity, idealHeight: reader.size.height * DrawingConstants.filterItemHeightPercentage)
                            .padding(.bottom, DrawingConstants.paddingBetweenElements)
                    }
                }
            }.padding()
        }
    }

    private func createToolbar() -> some View {
        NavigationLink(
            destination: { FilterEditView() }) {
            Image(systemName: "plus")

        }
    }

    private struct DrawingConstants {
        static let paddingBetweenElements: CGFloat = 4
        static let filterItemHeightPercentage = 0.15
    }
}

struct FiltersView_Previews: PreviewProvider {
    @StateObject static private var vm = FiltersViewModel()
    static var previews: some View {
        FiltersView()
            .environmentObject(vm)
    }
}
