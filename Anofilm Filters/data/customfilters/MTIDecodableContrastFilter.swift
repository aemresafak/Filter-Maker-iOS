//
//  MTIDecodableContrastFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation
import MetalPetal


class MTIDecodableContrastFilter: Codable {
    var filter = MTIContrastFilter()
    init() {
        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        filter.contrast = try container.decode(Float.self, forKey: .contrast)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filter.contrast, forKey: .contrast)
    }
    
    private enum CodingKeys: String, CodingKey {
        case contrast
    }
}


