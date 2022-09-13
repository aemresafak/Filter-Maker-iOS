//
//  MTICLAHEFilterExtensions.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 14.09.2022.
//

import Foundation
import MetalPetal

extension MTICLAHEFilter {
    func createBlueprint() -> MTICLAHEFilterBluePrint {
        MTICLAHEFilterBluePrint(
            clipLimit: clipLimit,
            gridTileWidth: tileGridSize.width,
            gridTileHeight: tileGridSize.height
        )
    }
}
