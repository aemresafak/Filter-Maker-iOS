//
//  Anofilm_FiltersApp.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 5.09.2022.
//

import SwiftUI

@main
struct Anofilm_FiltersApp: App {
    @StateObject private var filtersViewModel: FiltersViewModel = FiltersViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FiltersView()
            }
                .navigationViewStyle(.stack)
                .environmentObject(filtersViewModel)

        }
    }
}
