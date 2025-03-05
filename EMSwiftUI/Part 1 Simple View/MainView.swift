//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MangaListViewModel(service: MangaListService(network: Network()))
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text("Ошибка: \(error)")
                    .foregroundColor(.red)
            } else {
                MangaSectionView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    MainView()
}
