//
//  LevelsAdjustmentView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 15.09.2022.
//

import SwiftUI

struct LevelsAdjustmentView: View {


    @Binding var minimumLevel: Float
    @Binding var middleLevel: Float
    @Binding var maximumLevel: Float

    @Binding var minimumOutputLevel: Float
    @Binding var maximumOutputLevel: Float

    @State private var leftHolderPosition: CGFloat = 0
    @State private var rightHolderPosition: CGFloat = 0

    @State private var refreshSlider = false

    var body: some View {
        ScrollView {
            levelsAdjustmentView
                .padding()
            outputLevelsAdjustmentView
                .padding()
            Spacer()
                .frame(height: 60)
        }
    }

    private var levelsAdjustmentView: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    resetLevels()
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                }
            }
            HStack {
                Text("Min")
                Spacer()
                Text("Mid")
                Spacer()
                Text("Max")
            }
            TripleThumbSlider(minimumValue: $minimumLevel, middleValue: $middleLevel, maximumValue: $maximumLevel, refresh: $refreshSlider)
        }
    }


    private var outputLevelsAdjustmentView: some View {
        GeometryReader { reader in
            VStack(spacing: 4) {
                HStack {
                    Spacer()
                    Button {
                        resetOutputLevels(outputRectangleWidth: reader.size.width)
                    } label: {
                        Image(systemName: "arrow.uturn.backward")
                    }
                }
                outputRectangle
                    .border(.gray)
                holderRow(outputRectangleWidth: reader.size.width)
            }
                .onChange(of: leftHolderPosition, perform: { newValue in
                minimumOutputLevel = Float(newValue / reader.size.width)
            })
                .onChange(of: rightHolderPosition, perform: { newValue in
                maximumOutputLevel = Float(newValue / reader.size.width)
            })
                .onAppear {
                leftHolderPosition = CGFloat(minimumOutputLevel) * reader.size.width
                rightHolderPosition = CGFloat(maximumOutputLevel) * reader.size.width
            }
        }

            .frame(height: DrawingConstants.totalHeightWithoutPaddings, alignment: .center)
    }



    private var outputRectangle: some View {
        Rectangle()
            .foregroundStyle(LinearGradient(colors: [.white, .black], startPoint: .leading, endPoint: .trailing))
            .frame(height: DrawingConstants.outputRectangleHeight)
    }

    private func holderRow(outputRectangleWidth: CGFloat) -> some View {
        ZStack {
            leftHolder
                .position(x: leftHolderPosition, y: DrawingConstants.holderTotalHeight / 2)
                .gesture(leftHolderGesture(outputRectangleWidth: outputRectangleWidth))
            Spacer()
            rightHolder
                .position(x: rightHolderPosition, y: DrawingConstants.holderTotalHeight / 2)
                .gesture(rightHolderGesture(outputRectangleWidth: outputRectangleWidth))
        } .frame(width: outputRectangleWidth, alignment: .leading)
    }


    private func rightHolderGesture(outputRectangleWidth: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { gesture in
            let isLocationLessThanOrEqualToRightBorder = gesture.location.x <= outputRectangleWidth
            let isLocationGreaterThanOrEqualToLeftHolder = gesture.location.x >= leftHolderPosition
            if isLocationLessThanOrEqualToRightBorder && isLocationGreaterThanOrEqualToLeftHolder {
                rightHolderPosition = gesture.location.x
            }
        }
    }

    private func leftHolderGesture(outputRectangleWidth: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { gesture in
            let isLocationGreaterThanOrEqualToZero = gesture.location.x >= 0
            let isLocationLessThanOrEqualToRightHolder = gesture.location.x <= rightHolderPosition
            if isLocationGreaterThanOrEqualToZero && isLocationLessThanOrEqualToRightHolder {
                leftHolderPosition = gesture.location.x
            }
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

    func resetLevels() {
        minimumLevel = 0
        middleLevel = 1
        maximumLevel = 1
        refreshSlider.toggle()
        
        
    }
    
    func resetOutputLevels(outputRectangleWidth: CGFloat) {
        minimumOutputLevel = 0
        maximumOutputLevel = 1
        leftHolderPosition = 0
        rightHolderPosition = outputRectangleWidth
    }

    private struct DrawingConstants {
        static let holderWidth: CGFloat = 20
        static let holderTriangleHeight: CGFloat = 12
        static let holderRectangleHeight: CGFloat = 12
        static let holderColor = Color.gray
        static let outputRectangleHeight: CGFloat = 36
        static var totalHeightWithoutPaddings: CGFloat {
            holderRectangleHeight + holderTriangleHeight + outputRectangleHeight
        }
        static var holderTotalHeight: CGFloat {
            holderTriangleHeight + holderRectangleHeight
        }
    }
}

struct LevelsAdjustmentView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsAdjustmentView(
            minimumLevel: .constant(0),
            middleLevel: .constant(0.5),
            maximumLevel: .constant(1),
            minimumOutputLevel: .constant(0),
            maximumOutputLevel: .constant(1))
            .padding(32)

    }
}
