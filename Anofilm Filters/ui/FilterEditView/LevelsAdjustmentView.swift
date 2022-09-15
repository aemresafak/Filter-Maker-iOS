//
//  LevelsAdjustmentView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 15.09.2022.
//

import SwiftUI

struct LevelsAdjustmentView: View {
    var body: some View {
        outputRectangle
    }

    
    private var outputRectangle: some View {
        Rectangle()
            .foregroundStyle(LinearGradient(colors: [.white, .black], startPoint: .leading, endPoint: .trailing))
            .frame(height: DrawingConstants.outputRectangleHeight)
    }
    
    private func createHolder() -> some View {
        VStack(spacing: 0) {
            Triangle(inRectangle: CGRect(x: 0, y: 0, width: DrawingConstants.holderWidth, height: DrawingConstants.holderTriangleHeight))
            Rectangle()
                .frame(width: DrawingConstants.holderWidth, height: DrawingConstants.holderRectangleHeight)
        }
        .foregroundColor(DrawingConstants.holderColor)
    }
    
    private struct DrawingConstants {
        static let holderWidth: CGFloat = 16
        static let holderTriangleHeight: CGFloat = 9
        static let holderRectangleHeight: CGFloat = 9
        static let holderColor = Color.gray
        static let outputRectangleHeight: CGFloat = 32
    }
}

struct LevelsAdjustmentView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsAdjustmentView()
    }
}
