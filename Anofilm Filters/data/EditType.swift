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
    case brightness, contrast, saturation, exposure, vibrance, whiteBalance = "White Balance", gamma, haze, highlightsAndShadows = "Highlights and Shadows", sepiaTone = "Sepia Tone", tint
    case highlightTint = "Highlight Tint", shadowTint = "Shadow Tint"
}
