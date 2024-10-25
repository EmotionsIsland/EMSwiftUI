//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

// MARK: - MangaSectionView
struct MangaSectionView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = MangaListViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
    var body: some View {
        Group {
            switch viewModel.dataState {
            case .successfull:
                if viewModel.mangaData.isEmpty {
                    Text("No data available")
                        .font(.headline)
                        .foregroundColor(.gray)
                } else {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.mangaData) { manga in
                                MangaSingleGridView(manga: manga, viewModel: viewModel)
                            }
                        }
                    }
                }
                
            case .failed(let error):
                ErrorView(error: error)
                
            case .notAvailable:
                ProgressView("Loading...")
                    .font(.headline)
            }
        }
        .onAppear {
            viewModel.getData()
        }
    }
}

#Preview {
    MangaSectionView()
}

// MARK: - ErrorView
struct ErrorView: View {
    
    let error: Error
 
    var body: some View {
        VStack {
            Text("Failed to load manga")
                .font(.headline)
                .foregroundColor(.red)
            Text(error.localizedDescription)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
