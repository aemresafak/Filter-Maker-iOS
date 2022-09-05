//
//  FilterImageView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import SwiftUI
import MetalPetal

struct FilterImageView : UIViewRepresentable {
    @Binding var imageToDisplay: MTIImage?
    
    func makeUIView(context: Context) -> MTIImageView {
        let mtiImageView = MTIImageView()
        mtiImageView.image = imageToDisplay
        return mtiImageView
        
    }
    
    func updateUIView(_ uiView: MTIImageView, context: Context) {
        uiView.image = imageToDisplay
    }
}

