//
//  MTIDecodableSaturationFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation
import MetalPetal


class MTIDecodableSaturationFilter: Codable {
    var filter = MTISaturationFilter()
    init() {
        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        filter.saturation = try container.decode(Float.self, forKey: .saturation)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filter.saturation, forKey: .saturation)
    }
    
    private enum CodingKeys: String, CodingKey {
        case saturation
    }
}


