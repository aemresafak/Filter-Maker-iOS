//
//  AnofilmFilterExtensions.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation
import SwiftUI

extension AnofilmFilter {
    static let sampleFilters: [AnofilmFilter] = {
        let filter1 = AnofilmFilter(name: "Red Filter")
        filter1.setTintColor(.red)
        filter1.setTintIntensity(0.5)
        filter1.setBrightness(0.3)
        
        let filter2 = AnofilmFilter(name: "Yellowish Filter")
        filter2.setTintColor(.yellow)
        filter2.setTintIntensity(0.2)
        filter2.setBrightness(0.6)
        
        let filter3 = AnofilmFilter(name: "Blue Filter")
        filter3.setTintColor(.blue)
        filter3.setTintIntensity(0.8)
        filter3.setBrightness(0.2)
        
        return [filter1, filter2, filter3]
    }()
}


extension AnofilmFilter : Identifiable {
    var id: String {
        self.name
    }
}
