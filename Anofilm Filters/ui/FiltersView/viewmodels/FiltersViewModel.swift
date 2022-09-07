//
//  FiltersViewModel.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation

class FiltersViewModel: ObservableObject {

    func getFiltersURL() throws -> URL {
        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            throw URLError(.badURL)
        }
        return url.appendingPathComponent("filters.json")
    }



    @Published var filters: [AnofilmFilter] = []

    /// adds given filter to the filters list, and saves current state to internal storage
    func addFilter(_ filter: AnofilmFilter) {
        filters.append(filter)
        saveFilters()
    }
    
    init() {
        loadFilters()
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
