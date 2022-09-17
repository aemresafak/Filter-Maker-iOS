//
//  FiltersView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import SwiftUI
import UIKit

struct FiltersView: View {

    @EnvironmentObject var filtersViewModel: FiltersViewModel
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.colorScheme) private var colorScheme
    @State private var navigateToAddFilter = false
    @State private var showImportDialog = false
    @State private var isFilterImportedSuccessfully: Bool? = nil



    var body: some View {
        ZStack {
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
            importDialog
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
            FilterEditView()
        } label: {
            EmptyView()
        }
    }

    private func createFilterListItem(for filter: AnofilmFilter) -> some View {
        NavigationLink {
            FilterDetailView(
                filterIndex: filtersViewModel.findIndex(of: filter)
            )
        } label: {
            FilterItem(anofilmFilter: filter)
                .padding(.bottom, DrawingConstants.paddingBetweenElements)
        }
    }

    private func createToolbar() -> some View {
        HStack {
            Button {
                showImportDialog = true
            } label: {
                Text("Import")
            }
            EditButton()
            addFilterView
        }
    }

    private var importDialog: some View {
        CustomizableDialog(showDialog: $showImportDialog, onDismiss: {
            isFilterImportedSuccessfully = nil
        }) {
            VStack(spacing: 12) {
                Button {
                    isFilterImportedSuccessfully = filtersViewModel.importFilter(jsonString: getCopiedString())
                } label: {
                    Label("Paste", systemImage: "doc.on.clipboard")
                }
                Spacer()
                switch isFilterImportedSuccessfully {
                case .none:
                    Text("Paste to import filter.")
                case .some(let isAdded):
                    Text(isAdded ? "Filter has been added successfuly!" : "Filter could not be added. Make sure you copied the correct text.")
                }
                Spacer()
                Button("OK") {
                    isFilterImportedSuccessfully = nil
                    showImportDialog = false
                }
            }
                .padding()
                .frame(width: 250, height: 300, alignment: .center)
                .background(colorScheme == .light ? Color.white : Color.black)
        }
    }

    func getCopiedString() -> String? {
        let pb = UIPasteboard.general
        return pb.string
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
        NavigationView {
            FiltersView()
                .environmentObject(vm)
        }
    }
}
