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
            Group {
                if let url = coverURL {
                    AsyncImage(url: url) { phase in
                        if case .success(let image) = phase {
                            image
                                .resizable()
                                .scaledToFill()
                        } else {
                            placeholderView
                        }
                    }
                } else {
                    placeholderView
                }
            }
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

extension MangaSingleGridView {
    @ViewBuilder
    private var placeholderView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.2))
            
            if coverURL != nil {
                ProgressView()
            } else {
                Image(systemName: "book.closed.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                    .foregroundColor(.gray)
            }
        }
    }
}
