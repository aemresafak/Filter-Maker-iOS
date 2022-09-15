//
//  TripleThumbSlider.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 15.09.2022.
//

import SwiftUI

struct TripleThumbSlider: View {


    @State private var minThumbLocation: CGFloat = 0
    @State private var midThumbLocation: CGFloat = 0
    @State private var maxThumbLocation: CGFloat = 0

    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: DrawingConstants.rectangleCornerRadius)
                    .frame(height: DrawingConstants.sliderHeight)
                    .foregroundColor(DrawingConstants.inactiveSliderColor)
                    .opacity(0.5)
                minThumb
                    .position(x: minThumbLocation, y: DrawingConstants.thumbDiameter / 2)
                    .gesture(minThumbDragGesture)
                midThumb
                    .position(x: midThumbLocation, y: DrawingConstants.thumbDiameter / 2)
                    .gesture(midThumbDragGesture)
                maxThumb
                    .position(x: maxThumbLocation, y: DrawingConstants.thumbDiameter / 2)
                    .gesture(maxThumbDragGesture(sliderWidth: reader.size.width))
            }
                .onAppear {
                minThumbLocation = 0
                midThumbLocation = 0.5 * reader.size.width
                maxThumbLocation = reader.size.width
            }
        }
            .frame(height: DrawingConstants.thumbDiameter)
    }

    private var minThumbDragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
            let isLocationGreaterThanOrEqualToZero = gesture.location.x >= 0
            let isLocationLessThanMidThumb = gesture.location.x <= midThumbLocation
            if isLocationGreaterThanOrEqualToZero && isLocationLessThanMidThumb {
                midThumbLocation = calculateNewMidPosition(max: maxThumbLocation, min: minThumbLocation, mid: midThumbLocation, newMin: gesture.location.x)
                minThumbLocation = gesture.location.x
            }
        }
    }
    
    // newMid max - min max + min mid = newMax mid - min newMax  + newMid min
    
    private func calculateNewMidPosition(max: CGFloat, min: CGFloat, mid: CGFloat, newMin: CGFloat) -> CGFloat {
        if max == min {
            return min
        } else {
            return (max * (mid - min) - newMin * (mid - max)) / (max - min)
        }
    }
    
    private func calculateNewMidPosition(max: CGFloat, min:CGFloat, mid:CGFloat, newMax: CGFloat) -> CGFloat {
        if max - min == 0 {
            return max
        } else {
            return (newMax * (mid-min) + min * (max-mid)) / (max-min)
        }
    }

    private var midThumbDragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
            let isLocationGreaterThanMinThumb = gesture.location.x >= minThumbLocation
            let isLocationLessThanMaxThumb = gesture.location.x <= maxThumbLocation
            if isLocationLessThanMaxThumb && isLocationGreaterThanMinThumb {
                midThumbLocation = gesture.location.x
            }
        }
    }


    func maxThumbDragGesture(sliderWidth: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { gesture in
            let isLocationLessThanSliderWidth = gesture.location.x <= sliderWidth
            let isLocationGreaterThanMidThumb = gesture.location.x >= midThumbLocation
            if isLocationGreaterThanMidThumb && isLocationLessThanSliderWidth {
                midThumbLocation = calculateNewMidPosition(max: maxThumbLocation, min: minThumbLocation, mid: midThumbLocation, newMax: gesture.location.x)
                maxThumbLocation = gesture.location.x
                
            }
        }
    }



    private var minThumb: some View {
        createThumb()
    }

    private var midThumb: some View {
        createThumb()
    }

    private var maxThumb: some View {
        createThumb()
    }


    private func createThumb() -> some View {
        Circle()
            .foregroundColor(DrawingConstants.thumbColor)
            .frame(width: DrawingConstants.thumbDiameter, height: DrawingConstants.thumbDiameter)

    }


    private struct DrawingConstants {
        static let thumbColor = Color.init(red: 0.9, green: 0.1, blue: 0.1)
        static let thumbDiameter: CGFloat = 28
        static let sliderHeight: CGFloat = 12
        static let rectangleCornerRadius: CGFloat = 12
        static let inactiveSliderColor = Color(red: 0.4, green: 0.4, blue: 0.4)
    }
}

struct TripleThumbSlider_Previews: PreviewProvider {
    static var previews: some View {
        TripleThumbSlider()
            .padding()
    }
}
