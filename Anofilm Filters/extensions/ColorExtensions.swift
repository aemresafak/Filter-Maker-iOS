//
//  ColorExtensions.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 6.09.2022.
//

import SwiftUI
import MetalPetal

extension Color {
    func createFloat3() -> simd_float3 {
        let color = UIColor(self)
        guard let components = color.cgColor.components else {
            return SIMD3(1,1,1)
        }
        let red = Float(components[0])
        let green = Float(components[1])
        let blue = Float(components[2])
        
        return SIMD3(red, green, blue)
    }
    
    static func createFrom(vector: simd_float3) -> Color {
        Color(.sRGB, red: Double(vector.x), green: Double(vector.y), blue: Double(vector.z), opacity: 1)
    }
}
