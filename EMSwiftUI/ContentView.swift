//
//  ContentView.swift
//  EMSwiftUI
//
//  Created by User on 11.05.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MangaListViewModel(mangaService: MangaListService(network: Network()))

    var body: some View {
        MainView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
