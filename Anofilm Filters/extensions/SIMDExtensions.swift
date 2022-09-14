//
//  SIMDExtensions.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import Foundation
import MetalPetal
import SwiftUI

extension simd_float4x4: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let firstColumn = try container.decode(simd_float4.self, forKey: .firstColumn)
        let secondColumn = try container.decode(simd_float4.self, forKey: .secondColumn)
        let thirdColumn = try container.decode(simd_float4.self, forKey: .thirdColumn)
        let fourthColumn = try container.decode(simd_float4.self, forKey: .fourthColumn)
        self = simd_float4x4([firstColumn, secondColumn, thirdColumn, fourthColumn])
    }


    public func encode(to encoder: Encoder) throws {
        let firstColumn = self.columns.0
        let secondColumn = self.columns.1
        let thirdColumn = self.columns.2
        let fourthColumn = self.columns.3
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstColumn, forKey: .firstColumn)
        try container.encode(secondColumn, forKey: .secondColumn)
        try container.encode(thirdColumn, forKey: .thirdColumn)
        try container.encode(fourthColumn, forKey: .fourthColumn)
    }

    private enum CodingKeys: String, CodingKey {
        case firstColumn, secondColumn, thirdColumn, fourthColumn
    }
}

extension simd_float3 {
    func toColor() -> Color {
        Color(.sRGB, red: Double(self.x), green: Double(self.y), blue: Double(self.z), opacity: 1)
    }
}
