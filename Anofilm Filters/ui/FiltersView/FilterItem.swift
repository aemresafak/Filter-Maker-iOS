//
//  FilterItem.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import SwiftUI

struct FilterItem: View {
    
    let anofilmFilter: AnofilmFilter
    
    var body: some View {
        ZStack {
            backgroundView
            HStack {
                Label(anofilmFilter.name, systemImage: "pencil")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
            }.padding()
        }
    }
    
    private var backgroundView : some View {
        RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            .foregroundColor(DrawingConstants.backgroundColor)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 16
        static let backgroundColor = Color.init(red: 0.45, green: 0.45, blue: 0.45)
    }
}

struct FilterItem_Previews: PreviewProvider {
    static var previews: some View {
        FilterItem(anofilmFilter: AnofilmFilter(name: "My Filter")).frame(width: .infinity, height: 100).padding()
    }
}
