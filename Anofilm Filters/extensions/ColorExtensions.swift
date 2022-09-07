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

extension Color : Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Color.CodingKeys.self)
        let red = try container.decode(Double.self, forKey: .red)
        let green = try container.decode(Double.self, forKey: .green)
        let blue = try container.decode(Double.self, forKey: .blue)
        let alpha = try container.decode(Double.self, forKey: .alpha)
        self = Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
    
    public func encode(to encoder: Encoder) throws {
        let color = UIColor(self)
        guard let components = color.cgColor.components else {
            throw ColorError.componentError
        }
        let red = Double(components[0])
        let green = Double(components[1])
        let blue = Double(components[2])
        let alpha = Double(components[3])
        var container = encoder.container(keyedBy: Color.CodingKeys.self)
        try container.encode(red, forKey: .red)
        try container.encode(green, forKey: .green)
        try container.encode(blue, forKey: .blue)
        try container.encode(alpha, forKey: .alpha)
    }
    
    
    private enum CodingKeys: String, CodingKey  {
        case red, green, blue, alpha
    }
}
