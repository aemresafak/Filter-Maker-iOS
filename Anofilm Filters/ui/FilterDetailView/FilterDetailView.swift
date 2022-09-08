//
//  FilterDetailView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct FilterDetailView: View {
    @Binding var filter: AnofilmFilter
    @State private var showCopyToastMessage = false
    var body: some View {
        ZStack {
            Color(.sRGB, red: 0.25, green: 0.25, blue: 0.25, opacity: 1).ignoresSafeArea()
            ScrollView {
                actionHStack()
                Text(filter.description)
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineSpacing(8)
                    .padding()
                colorDisplayView
            }
            ToastMessage(showMessage: $showCopyToastMessage) {
                toastContent
            }
        }
            .navigationTitle("Filter Details")
            .navigationBarTitleDisplayMode(.inline)
    }

    private func actionHStack() -> some View {
        HStack {
            NavigationLink(destination: {
                FilterEditView(filter: filter)
            }) {
                Label("Edit", systemImage: "pencil")
            }
            Button {
                copyTextToClipboard(filter.description)
            } label: {
                Label("Copy to clipboard", systemImage: "doc.on.doc")
                    .padding(.horizontal)
            }
            Spacer()
        }
            .font(.title2)
            .padding()
    }

    private var toastContent: some View {
        Text("Message is copied!")
            .padding()
            .background(
            RoundedRectangle(cornerRadius: DrawingConstants.toastMessageCornerRadius)
                .foregroundColor(.white)
        )
            .font(.largeTitle)
            .shadow(radius: DrawingConstants.toastMessageShadowRadius)
    }

    private var colorDisplayView: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Colors used")
                .font(.title)
                .padding([.bottom, .horizontal])
            createColorDescription("Tint Color", color: filter.getTintColor())
                .font(.title3)
                .padding([.bottom, .horizontal])
            createColorDescription("Highlight Tint Color", color: filter.getHighlightTintColor())
                .font(.title3)
                .padding([.bottom, .horizontal])
            createColorDescription("Shadow Tint Color", color: filter.getShadowTintColor())
                .font(.title3)
                .padding([.bottom, .horizontal])
            createColorDescription("Vignette Color", color: filter.getVignetteColor())
                .font(.title3)
                .padding([.bottom, .horizontal])
        }
            .foregroundColor(.white)
    }

    private func createColorDescription(_ description: String, color: Color) -> some View {
        HStack {
            Text(description).padding(.trailing, 4)
            createColorCircle(color)
            Spacer()
        }
    }

    private func createColorCircle(_ color: Color) -> some View {
        Circle()
            .foregroundColor(color)
            .frame(width: DrawingConstants.colorCircleDiameter, height: DrawingConstants.colorCircleDiameter)
    }

    private func copyTextToClipboard(_ text: String) {
        UIPasteboard.general.setValue(text, forPasteboardType: UTType.plainText.identifier)
        withAnimation {
            showCopyToastMessage = true
        }
    }

    private struct DrawingConstants {
        static let toastMessageCornerRadius: CGFloat = 8
        static let toastMessageShadowRadius: CGFloat = 8
        static let colorCircleDiameter: CGFloat = 36
    }

}

struct FilterDetailView_Previews: PreviewProvider {
    @State static var filter = AnofilmFilter(name: "ali")
    static var previews: some View {
        NavigationView {
            FilterDetailView(filter: $filter)
        }
    }
}
