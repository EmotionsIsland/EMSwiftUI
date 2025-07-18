//
//  CoverView.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/13/25.
//

import SwiftUI

struct MangaCoverView<ViewModel: MangaListViewModel>: View {
    var url: URL?
    
    @State private var image: UIImage?
    @StateObject private var viewModel: ViewModel
    
    init(url: URL?, viewModel: ViewModel) {
        self.url = url
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizedToFill(width: 100, height: 144)
                    .cornerRadius(4)
            } else {
                EmptyView()
            }
        }
        .task {
            image = await viewModel.loadImage(url)
        }
    }
}
