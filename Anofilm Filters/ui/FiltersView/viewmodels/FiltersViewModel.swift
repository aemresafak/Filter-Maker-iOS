//
//  FiltersViewModel.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation

class FiltersViewModel : ObservableObject {
    @Published var filters: [AnofilmFilter] = AnofilmFilter.sampleFilters
    
    
    /// Saves filters to internal storage
    func saveFilters() {
        
    }
    
    /// Loads filters from internal storage and updates filters
    func loadFilters() {

    }
    
}
