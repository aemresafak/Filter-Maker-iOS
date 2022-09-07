//
//  FiltersViewModel.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation

class FiltersViewModel: ObservableObject {
    @Published var filters: [AnofilmFilter] = AnofilmFilter.sampleFilters


    /// adds given filter to the filters list, and saves current state to internal storage
    func addFilter(_ filter: AnofilmFilter) {
        filters.append(filter)
        saveFilters()
    }

    /// Saves filters to internal storage
    func saveFilters() {

    }

    /// Loads filters from internal storage and updates filters
    func loadFilters() {

    }

}
