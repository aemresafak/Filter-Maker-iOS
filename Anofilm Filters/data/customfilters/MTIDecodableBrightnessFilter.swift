//
//  MTIDecodableBrightnessFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation
import MetalPetal


class MTIDecodableBrightnessFilter: Codable {
    var filter = MTIBrightnessFilter()
    init() {
        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        filter.brightness = try container.decode(Float.self, forKey: .brightness)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filter.brightness, forKey: .brightness)
    }

    private enum CodingKeys: String, CodingKey {
        case brightness
    }
}

