//
//  FiltersViewModel.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation

class FiltersViewModel: ObservableObject {

    func getFiltersURL() throws -> URL {
        let url = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return url.appendingPathComponent("filters.json")
    }



    @Published var filters: [AnofilmFilter] = []

    
    init() {
        loadFilters()
    }

    func findIndex(of filter: AnofilmFilter) -> Int {
        let index = filters.firstIndex(where: {
            $0.name == filter.name
        })
        return index ?? -1
    }
    
    /// Saves filters to internal storage
    func saveFilters() {
        Task {
            do {
                let url = try getFiltersURL()
                let data = try JSONEncoder().encode(filters)
                try data.write(to: url)
            } catch {
                print("Filters could not be saved \(error.localizedDescription)")
            }
        }
    }

    /// Loads filters from internal storage and updates filters
    func loadFilters() {
        do {
            let url = try getFiltersURL()
            let data = try Data(contentsOf: url)
            filters = try JSONDecoder().decode([AnofilmFilter].self, from: data)
        } catch {
            print("Filters could not be loaded \(error.localizedDescription)")
        }
    }

}
