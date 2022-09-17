//
//  SwiftUIView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 17.09.2022.
//

import SwiftUI

struct ColorSliderView: View {

    var color: Color
    @Binding var value: Float
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 32, height: 32)
                .padding(.trailing)
            Slider(value: $value, in: 0...1)
            Button {
                value = 1
            } label: {
                Image(systemName: "arrow.uturn.backward")
            }.padding(.leading)
        }
            .padding()
    }


}

