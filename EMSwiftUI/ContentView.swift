//
//  ContentView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: MangaListViewModel
    
    init() {
        let network = Network()
        let service = MangaListService(network: network)
        self._viewModel = StateObject(wrappedValue: MangaListViewModel(mangaService: service))
    }
    var body: some View {
        MainView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
