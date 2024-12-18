//
//  ContentView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView(viewModel: MangaListViewModel(mangaListService: MangaListService(network: Network())))
    }
}

#Preview {
    ContentView()
}
