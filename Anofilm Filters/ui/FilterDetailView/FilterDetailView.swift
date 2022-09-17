//
//  FilterDetailView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 7.09.2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct FilterDetailView: View {
    let filterIndex: Int

    @State private var filter: AnofilmFilter = AnofilmFilter()
    @EnvironmentObject var filtersViewModel: FiltersViewModel



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
            .onAppear {
            self.filter = filtersViewModel.filters[filterIndex]
        }
            .navigationTitle("Filter Details")
            .navigationBarTitleDisplayMode(.inline)
    }

    private func actionHStack() -> some View {
        HStack {
            NavigationLink(destination: {
                FilterEditView(filterIndex: filterIndex)
            }) {
                Label("Edit", systemImage: "pencil")
            }
            Button {
                copyFilterJsonToClipboard(filter)
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

    private func copyFilterJsonToClipboard(_ filter: AnofilmFilter) {
        do {
            let json = try JSONEncoder().encode(filter)
            let jsonString = String(data: json, encoding: .utf8)
            copyTextToClipboard(jsonString ?? "Filter could not be copied")
        } catch {
            copyTextToClipboard(error.localizedDescription)
        }
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
