//
//  CustomizableDialog.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import SwiftUI

struct CustomizableDialog<Content: View>: View {
    
    @Binding var showDialog: Bool
    var onDismiss: (() -> Void)?
    
    @ViewBuilder var content:  () -> Content
    
    var body: some View {
        if showDialog {
            ZStack {
                Rectangle()
                    .foregroundColor(DrawingConstants.blurColor)
                    .ignoresSafeArea()
                    .onTapGesture {
                        onDismiss?.self()
                        showDialog = false
                    }
                content()
                    .padding()
            }
        } else {
            EmptyView()
        }
       
    }
    

}
fileprivate struct DrawingConstants {
    static let blurColor = Color.init(.sRGB, red: 0.1, green: 0.1, blue: 0.1, opacity: 0.85)
}

struct CustomizableDialog_Previews: PreviewProvider {
    static var previews: some View {
        CustomizableDialog(showDialog: .constant(true)) {
            Text("ahmet emre")
        }
    }
}
