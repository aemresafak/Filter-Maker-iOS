//
//  MTIClaheFilterBlueprint.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 14.09.2022.
//

import Foundation
import MetalPetal

struct MTICLAHEFilterBluePrint: Codable {
    let clipLimit: Float
    let gridTileWidth: UInt
    let gridTileHeight: UInt
    
    func createMTICLAHEFilter() -> MTICLAHEFilter {
        let filter = MTICLAHEFilter()
        let tileGrid = MTICLAHESize(width: gridTileWidth, height: gridTileHeight)
        filter.tileGridSize = tileGrid
        filter.clipLimit = clipLimit
        return filter
    }
}
