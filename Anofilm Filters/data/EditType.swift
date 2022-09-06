//
//  EditType.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import Foundation

enum EditType : String, CaseIterable, Identifiable {
    var id : Self {
        self
    }
    case brightness, contrast, saturation, exposure, vibrance, whiteBalance, gamma, haze, highlightsAndShadows
}
