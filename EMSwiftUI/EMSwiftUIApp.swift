//
//  EMSwiftUIApp.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

@main
struct EMSwiftUIApp: App {
    var service = MangaListService(network: Network())
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MangaListViewModel(service: service))
                .environmentObject(FiltersViewModel(service: service))
        }
    }
}
