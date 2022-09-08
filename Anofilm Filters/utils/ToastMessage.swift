//
//  ToastMessage.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 8.09.2022.
//

import SwiftUI

struct ToastMessage<Content: View>: View {
    @Binding var showMessage: Bool
    var messageLength: Float = 2
    @ViewBuilder let content: () -> Content

    var body: some View {
        if showMessage {
            ZStack {
                Color(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.001)
                content()

            }
                .ignoresSafeArea()
                .onTapGesture {
                withAnimation {
                    showMessage = false
                }
            }
                .onAppear {
                dismissToastMessageAfter(seconds: messageLength)
            }

        } else {
            EmptyView()
        }
    }

    private func dismissToastMessageAfter(seconds: Float) {
        Task {
            try? await Task.sleep(nanoseconds: UInt64(seconds * 1e9))
            withAnimation {
                showMessage = false
            }
        }
    }
}

struct ToastMessage_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        ToastMessage(showMessage: $show) {
            Text("Ahmet Emre")
        }
    }
}
