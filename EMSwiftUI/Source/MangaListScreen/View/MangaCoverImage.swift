//
//  MangaCoverImage.swift
//  EMSwiftUI
//
//  Created by Антон Баландин on 4.04.25.
//

import SwiftUI

struct MangaCoverImage: View {
    let url: URL?
    
    var body: some View {
        Group {
            if let url = url {
                AsyncImage(
                    url: url,
                    content: { image in
                        image
                            .resizable()
                            .scaledToFill()
                    },
                    placeholder: {
                        placeholderView(showProgress: true)
                    }
                )
            } else {
                placeholderView(showProgress: false)
            }
        }
    }
}

private extension MangaCoverImage {
    @ViewBuilder
    func placeholderView(showProgress: Bool) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.2))
            
            if showProgress {
                ProgressView()
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                    .foregroundColor(.gray)
            }
        }
    }
}
