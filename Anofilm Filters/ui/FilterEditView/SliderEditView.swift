//
//  SliderEditView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 17.09.2022.
//

import SwiftUI

struct SliderEditView: View {
    var editName: String
    @Binding var value: Float
    var range: ClosedRange<Float>
    var resetValue: Float?
    
    var body: some View {
        VStack {
            HStack {
                Text("\(editName): \(value, specifier: "%.2f")")
                Spacer()
                Button(action: { value = resetValue == nil ? (range.lowerBound + range.upperBound) / 2 : resetValue! }) {
                    Image(systemName: "arrow.uturn.backward")
                }
            }
            Slider(value: $value, in: range)
        }.padding()
    }
    
}

