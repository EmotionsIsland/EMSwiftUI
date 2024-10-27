//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {

    @StateObject private var mangaListViewModel = MangaListViewModel(mangaListService: MangaListService(network: Network()))

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        HStack {
            MangaSectionTitleView()

            Spacer()

            Button(action: {

            }, label: {
                Text("more")
                    .foregroundStyle(.gray)
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            })
        }.padding([.leading, .trailing], 16)

            .frame(alignment: .topLeading)
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(mangaListViewModel.mangaData, id: \.id) { item in
                MangaSingleGridView(
                    mangaListViewModel: mangaListViewModel, 
                    mangaData: item,
                    imageURL: mangaListViewModel.getCoverURL(
                        manga: item, sizeFormat: SizeFormat.size256
                    )
                )
            }
        }.onAppear { [weak mangaListViewModel] in
            mangaListViewModel?.loadData()
        }
        Spacer()
    }
}

//#Preview {
//    MangaSectionView(viewModel: MangaListViewModel())
//}
