//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MangaListViewModel
    @State var searchText = ""
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 7)
                .padding(.horizontal)
                .frame(height: 36)
                .foregroundStyle(.grayBase)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.grayBase)
                .padding(.bottom, 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0..<3) { _ in
                    MangaSectionView(viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    MainView(viewModel: MangaListViewModel(mangaService: MangaListService(network: Network())))
}
