//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MangaListViewModel(
        mangaListService: MangaListService(network: Network()))
    
    @State private var isFilterShown = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .successfull, .notAvailable:
                    searchField
                    Divider()
                    contentView
                case .failed(let error):
                    Text("Error: \(error.localizedDescription)")
                        .frame(alignment: .center)
                }
            }
        }
        .fullScreenCover(isPresented: $isFilterShown) {
            FilterView()
        }
    }
}

#Preview {
    MainView()
}

private extension MainView {
    var searchField: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                    .padding(.leading, 4)
                
                TextField("Search", text: $searchText)
                    .frame(height: 36)
                    .padding(.leading, 4)
            }
            .background(.grayBase)
            .cornerRadius(8)
            
            Button("Filter") {
                isFilterShown.toggle()
            }
            .foregroundStyle(.blackBase)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
    }
    
    var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                ForEach(viewModel.categories, id: \.self) { title in
                    MangaSectionView(
                        sectionTitle: title,
                        viewModel: viewModel
                    )
                }
            }
            .padding()
        }
    }
}
