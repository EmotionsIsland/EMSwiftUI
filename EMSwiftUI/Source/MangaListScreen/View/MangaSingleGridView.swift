//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    var url: URL?
    
    var title: String
    
    var rating: Double
    
    var genres: [String]
    
    var body: some View {
        VStack(spacing: 5) {
            image()
            
            titleView()
            
            RatingView(rating: rating, maxRating: 5)
            
            gernres()
        }
    }
}

private extension MangaSingleGridView {
    @ViewBuilder func image() -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
            case .failure(_):
                Image(systemName: "photo")
                    .resizable()
            @unknown default:
                Text("Unknown error occurred.")
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(height: 150)
    }
    
    @ViewBuilder func titleView() -> some View {
        Text(title)
            .foregroundStyle(.blackBase)
            .font(Font.SFPro.bodyNormal)
            .lineLimit(1)
    }
    
    @ViewBuilder func gernres() -> some View {
        let text = genres.reduce("", { $0 + ", " + $1 })
        
        Text(text)
            .foregroundStyle(.grayBase)
            .font(Font.SFPro.lightSmall)
            .lineLimit(1)
    }
}
