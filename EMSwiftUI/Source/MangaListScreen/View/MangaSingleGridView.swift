//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let title: String
    let subtitle: String
    let rating: Double
    let coverURL: URL?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            imageBlock
            
            Text(title)
                .font(Font.SFPro.mediumNormal)
                .lineLimit(1)
            
            RatingView(rating: rating)
            
            Text(subtitle)
                .font(Font.SFPro.lightSmall)
                .foregroundStyle(.blackBase)
                .lineLimit(1)
        }
    }
    
    @ViewBuilder
    private var imageBlock: some View {
        AsyncImage(url: coverURL) { image in
            image
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, minHeight: 144)
                .aspectRatio(contentMode: .fill)
                .clipped()
        } placeholder: {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(maxWidth: .infinity, minHeight: 144)
                .redacted(reason: .placeholder)
                .overlay(
                    ShimmerView()
                        .mask(
                            Rectangle()
                                .frame(height: 144)
                        )
                )
        }
        .cornerRadius(6)
        .padding(.bottom, 4)
    }
}
