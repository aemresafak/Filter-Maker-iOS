//
//  FiltersViewModel.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation

class FiltersViewModel: ObservableObject {




    @Published var filters: [AnofilmFilter] = []

    init() {
        loadFilters()
    }

    func getFiltersURL() throws -> URL {
        let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return url.appendingPathComponent("filters.json")
    }

    func findIndex(of filter: AnofilmFilter) -> Int {
        let index = filters.firstIndex(where: {
            $0.id == filter.id
        })
        return index ?? -1
    }

    func importFilter(jsonString: String) -> Bool {
        guard let json = jsonString.data(using: .utf8) else { return false }
        guard let filter = try? JSONDecoder().decode(AnofilmFilter.self, from: json) else { return false }
        filters.append(filter)
        return true
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

    func deleteFilters(_ indexSet: IndexSet) {
        filters.remove(atOffsets: indexSet)
    }

    func moveFilters(fromOffsets: IndexSet, toOffset: Int) {
        filters.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }

}
