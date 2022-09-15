//
//  LevelsAdjustmentView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 15.09.2022.
//

import SwiftUI

struct LevelsAdjustmentView: View {

    @Binding var minimumOutputLevel: Float
    @Binding var maximumOutputLevel: Float
    
    
    
    @GestureState private var leftHolderPositionGestureState: CGFloat = 0
    @State private var leftHolderPositionSteadyState: CGFloat = 0
    private var leftHolderPosition: CGFloat {
        leftHolderPositionSteadyState + leftHolderPositionGestureState
    }

    var body: some View {
        GeometryReader { reader in
            VStack(spacing: 0) {
                outputRectangle
                holderRow
            }
        }
            .frame(height: DrawingConstants.totalHeightWithoutPaddings, alignment: .center)

    }



    private var outputRectangle: some View {
        Rectangle()
            .foregroundStyle(LinearGradient(colors: [.white, .black], startPoint: .leading, endPoint: .trailing))
            .frame(height: DrawingConstants.outputRectangleHeight)
    }

    private var holderRow: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
            }
            ZStack {
                
            }
            HStack(spacing: 0) {
                leftHolder
                    .offset(x: leftHolderPosition, y: 0)
                    .gesture(leftHolderGesture)
                Spacer()
                rightHolder
            }
        }
    }
    
    private var leftHolderGesture: some Gesture {
        DragGesture()
            .updating($leftHolderPositionGestureState) { drag, leftHolderPositionGestureState, _ in
                leftHolderPositionGestureState = drag.translation.width
            }
            .onEnded { drag in
                leftHolderPositionSteadyState += drag.translation.width
            }
    }

    private var leftHolder: some View { createHolder() }
    private var rightHolder: some View { createHolder() }

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
        static var totalHeightWithoutPaddings: CGFloat {
            holderRectangleHeight + holderTriangleHeight + outputRectangleHeight
        }
    }
}

struct LevelsAdjustmentView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsAdjustmentView(minimumOutputLevel: .constant(0), maximumOutputLevel: .constant(1))
    }
}
