//
//  FiltersView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import SwiftUI

struct FiltersView: View {

    @EnvironmentObject var filtersViewModel: FiltersViewModel
    @Environment(\.scenePhase) private var scenePhase
    @State private var navigateToFilterEdit = false

    var body: some View {
        filtersView
            .toolbar(content: createToolbar)
            .navigationTitle("Filters")
            .onChange(of: scenePhase) { newValue in
            switch newValue {
            case .background, .inactive:
                filtersViewModel.saveFilters()
            default:
                return
            }
        }


    }

    private var filtersView: some View {
        GeometryReader { reader in

            NavigationLink(isActive: $navigateToFilterEdit) {
                FilterEditView(anofilmFilter: $filtersViewModel.filters.last ?? .constant(AnofilmFilter()))
            } label: {
                EmptyView()
            }

            ScrollView {
                ForEach(filtersViewModel.filters) { filter in
                    NavigationLink {
                        FilterDetailView(filter: $filtersViewModel.filters[filtersViewModel.findIndex(of: filter)])
                    } label: {
                        FilterItem(anofilmFilter: filter)
                            .frame(maxWidth: .infinity, idealHeight: reader.size.height * DrawingConstants.filterItemHeightPercentage)
                            .padding(.bottom, DrawingConstants.paddingBetweenElements)
                    }
                }
            }
                .padding()
        }
    }

    private func createToolbar() -> some View {
        Button {
            filtersViewModel.filters.append(AnofilmFilter())
            navigateToFilterEdit = true
        } label: {
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
