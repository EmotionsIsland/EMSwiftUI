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
    
    var body: some View {
        VStack {
           MangaSectionTitleView(title: title)
            
            if viewModel.mangs.isEmpty {
                mangsListPlaceholder()
            } else {
                mangsList()
            }
        }
    }
}

private extension MangaSectionView {
    func mangsList() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 25),count: 3), spacing: 10) {
            ForEach(viewModel.mangs) { mang in
                MangaSingleGridView(manga: mang,
                                    imageURL: viewModel.getCoverURL(manga: mang, sizeFormat: .size256))
            }
        }
    }
    
    func mangsListPlaceholder() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 25),count: 3), spacing: 10) {
            ForEach(0..<6, id: \.self) { _ in
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                        .frame(width: 100, height: 144)
                    
                    Text("Preview text")
                        .font(.headline)
                        .lineLimit(1)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.gray)
                        }
                    
                    HStack(spacing: 0) {
                        ForEach(0..<5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .font(.callout)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Text("Preview textxxx")
                        .font(.callout)
                        .lineLimit(1)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.gray)
                        }
                }
                .frame(width: 100)
            }
        }
    }
}

