//
//  MangaCoverImage.swift
//  EMSwiftUI
//
//  Created by Глеб Капустин on 17.04.2025.
//

import SwiftUI

struct MangaCoverImage: View {
    let urlForImage: URL?

    var body: some View {
        AsyncImage(url: urlForImage) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 144)
                .clipShape(RoundedRectangle(cornerRadius: 4))
        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.whiteText)
                ProgressView()
            }
            .frame(width: 100, height: 144)
        }
    }
}
