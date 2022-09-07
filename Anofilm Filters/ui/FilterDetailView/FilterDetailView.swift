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
    var body: some View {
        ScrollView {
            VStack {
                Text("Filter Name: \(filter.name)")
                NavigationLink(destination: {
                    FilterEditView(filter: filter)
                }) {
                    Text("EDIT FILTER")
                }
                Button {
                    do {
                        let json = try JSONEncoder().encode(filter)
                        let string = String(data: json, encoding: .utf8)
                        UIPasteboard.general.setValue(string ?? "COULD NOT COPY, an error occurred",
                                    forPasteboardType: UTType.plainText.identifier)
                    } catch {
                        
                    }
                } label: {
                    Text("COPY INFORMATION FOR DEVELOPER")
                }


                createFilterPair("Brightness", value: filter.getBrightness())
                createFilterPair("Contrast", value: filter.getContrast())
                createFilterPair("Saturation", value: filter.getSaturation())
                createFilterPair("Exposure", value: filter.getExposure())
                createFilterPair("Vibrance", value: filter.getVibrance())
                VStack {
                    createFilterPair("White Balance Temperature", value: filter.getWhiteBalanceTemperature())
                    createFilterPair("White Balance Hue", value: filter.getWhiteBalanceHue())
                    createFilterPair("Gamma", value: filter.getGamma())
                    createFilterPair("Haze Distance", value: filter.getHazeDistance())
                    createFilterPair("Haze Slope", value: filter.getHazeSlope())
                    createFilterPair("Highlights", value: filter.getHighlights())
                    createFilterPair("Shadows", value: filter.getShadows())
                    createColorPair("Tint Color", color: filter.getTintColor())
                    createFilterPair("Tint Intensity", value: filter.getTintIntensity())
                    createFilterPair("Sepia Tone Intensity", value: filter.getSepiaTone())
                }
                VStack {
                    createFilterPair("Highlight Tint Intensity", value: filter.getHighlightTintIntensity())
                    createColorPair("Highlight Tint Color", color: filter.getHighlightTintColor())
                    createFilterPair("Shadow Tint Intensity", value: filter.getShadowTintIntensity())
                    createColorPair("Shadow Tint Color", color: filter.getShadowTintColor())
                    createFilterPair("Vignette Center X", value: filter.getVignetteCenterX())
                    createFilterPair("Vignette Center Y", value: filter.getVignetteCenterY())
                    createColorPair("Vignette Color", color: filter.getVignetteColor())
                    createFilterPair("Vignette Start", value: filter.getVignetteStart())
                    createFilterPair("Vignette End", value: filter.getVignetteEnd())

                }
            
            }
        }
       
    }
    
    func createColorPair(_ name: String, color: Color) -> some View {
        HStack {
            Text(name)
            Circle()
                .frame(width: 36, height: 36)
                .foregroundColor(color)
        }.padding()
    }
    
    func createFilterPair(_ name: String, value: Float) -> some View {
        Text("\(name): \(value)")
            .padding()
    }
}

struct FilterDetailView_Previews: PreviewProvider {
    @State static var filter = AnofilmFilter(name: "ali")
    static var previews: some View {
        FilterDetailView(filter: $filter)
    }
}
