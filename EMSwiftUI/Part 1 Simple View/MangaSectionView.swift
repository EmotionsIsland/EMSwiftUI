//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    @ObservedObject var viewModel: MangaListViewModel
    let title: String
    let mangaList: [MangaData]
    private let columns = [GridItem(.fixed(100), spacing: 25),
                   GridItem(.fixed(100), spacing: 25),
                   GridItem(.fixed(100))]
   
    var body: some View {
        VStack {
            MangaSectionTitleView(sectionTitle: title)
                        .padding(.horizontal, 4)
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(mangaList) { manga in
                            MangaSingleGridView(viewModel: viewModel, manga: manga)
                        }
                    }
            }
        
        }
}

#Preview {
    let netwok = Network()
    let service = MangaListService(network: netwok)
    let viewModel = MangaListViewModel(mangaService: service)
    MangaSectionView(viewModel: viewModel, title: "Test", mangaList: [])
}
