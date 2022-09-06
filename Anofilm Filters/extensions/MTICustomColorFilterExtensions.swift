//
//  MTICustomColorFilterExtensions.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

import Foundation
import SwiftUI
import MetalPetal

extension MTICustomColorMatrixFilter {
    static let noColorMatrix = simd_float4x4(rows: [
        SIMD4(1, 0, 0, 0),
        SIMD4(0, 1, 0, 0),
        SIMD4(0, 0, 1, 0),
        SIMD4(0, 0, 0, 0),

    ])
    
    static func createMatrix(from color: Color) -> simd_float4x4 {
        guard let components = UIColor(color).cgColor.components else {
            return MTICustomColorMatrixFilter.noColorMatrix
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let a = Float(components[3])
        return simd_float4x4(rows: [
            SIMD4(r, 0, 0, 0),
            SIMD4(0,g,0,0),
            SIMD4(0,0,b,0),
            SIMD4(0,0,0,a),

        ])
    }
    
    static func createColor(from matrix: simd_float4x4) -> Color {
        let red = Double(matrix.columns.0[0])
        let green = Double(matrix.columns.1[1])
        let blue = Double(matrix.columns.2[2])
        let alpha = Double(matrix.columns.3[3])
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
        
    }
}
