//
//  ContentView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct ContentView: View {
    @StateObject var viewModel = MangaListViewModel(mangaService: MangaListService(network: Network()))

    var body: some View {
        MainView(viewModel: viewModel)
    }
}

