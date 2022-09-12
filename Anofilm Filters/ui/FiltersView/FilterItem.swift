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
        Label(anofilmFilter.name,systemImage: "pencil")
            .font(.title)
    }


    private struct DrawingConstants {

    }
}

struct FilterItem_Previews: PreviewProvider {
    static var previews: some View {
        FilterItem(anofilmFilter: AnofilmFilter(name: "My Filter")).frame(width: .infinity, height: 100).padding()
    }
}
