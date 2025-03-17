//
//  ContentView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: MangaListViewModel = MangaListViewModel(mangaService: MangaListService(network: Network()))
    var body: some View {
        MainView(viewModel: viewModel)
    }
}
