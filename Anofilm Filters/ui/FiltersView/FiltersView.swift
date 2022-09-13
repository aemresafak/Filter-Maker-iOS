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
    @State private var navigateToAddFilter = false


   
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
        ZStack {
            addFilterNavigationLink
            List {
                ForEach(filtersViewModel.filters) { filter in
                    createFilterListItem(for: filter)
                }
                    .onDelete(perform: filtersViewModel.deleteFilters)
                    .onMove(perform: filtersViewModel.moveFilters)
            }
                .listStyle(.plain)
        }
    }

    private var addFilterNavigationLink: some View {
        NavigationLink(isActive: $navigateToAddFilter) {
            let filterEditViewModel = FilterEditViewModel(filter: Binding(get: {filtersViewModel.draftFilter}, set: {filtersViewModel.draftFilter = $0}))
            FilterEditView(
                shouldAddFilterToFilters: true,
                filterEditViewModel: filterEditViewModel
            )
        } label: {
            EmptyView()
        }
    }

    private func createFilterListItem(for filter: AnofilmFilter) -> some View {
        NavigationLink {
            FilterDetailView(
                filter: $filtersViewModel.filters[filtersViewModel.findIndex(of: filter)]
            )
        } label: {
            FilterItem(anofilmFilter: filter)
                .padding(.bottom, DrawingConstants.paddingBetweenElements)
        }
    }

    private func createToolbar() -> some View {
        HStack {
            EditButton()
            addFilterView
        }
    }



    private var addFilterView: some View {
        Button {
            navigateToAddFilter = true
        } label: {
            Image(systemName: "plus")
        }
    }

    private struct DrawingConstants {
        static let paddingBetweenElements: CGFloat = 4
    }
}

struct FiltersView_Previews: PreviewProvider {
    @StateObject static private var vm = FiltersViewModel()
    static var previews: some View {
        FiltersView()
            .environmentObject(vm)
    }
}
