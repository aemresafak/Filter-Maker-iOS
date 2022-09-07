//
//  MTIDecodableExposureFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation
import MetalPetal


class MTIDecodableExposureFilter : Codable {
    var filter = MTIExposureFilter()
    init() {
        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        filter.exposure = try container.decode(Float.self, forKey: .exposure)
    }
    

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filter.exposure, forKey: .exposure)
    }
    
    private enum CodingKeys: String, CodingKey {
        case exposure
    }
}

