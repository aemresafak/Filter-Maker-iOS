//
//  MTICodableVibranceFilter.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation
import MetalPetal


class MTICodableVibranceFilter : Codable{
    var filter = MTIVibranceFilter()
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        filter.amount = try container.decode(Float.self, forKey: .vibrance)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filter.amount, forKey: .vibrance)
    }
    
    private enum CodingKeys: String, CodingKey {
        case vibrance
    }
    init() {
        
    }
}



  
