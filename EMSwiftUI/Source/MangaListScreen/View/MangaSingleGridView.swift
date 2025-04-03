//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Factory

struct MangaSingleGridView: View {
    let title: String
    let description: String
    let coverURL: URL?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            coverImage
                .aspectRatio(2/3, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .frame(maxWidth: .infinity)
            
            Text(title)
                .font(Font.SFPro.mediumNormal)
                .foregroundColor(.blackBase)
                .lineLimit(1)
            
            RatingView()
            
            Text(description)
                .font(Font.SFPro.lightSmall)
                .foregroundColor(.grayBase)
                .lineLimit(1)
        }
    }
}

private extension MangaSingleGridView {
    @ViewBuilder
    var coverImage: some View {
        Group {
            if let url = coverURL {
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
