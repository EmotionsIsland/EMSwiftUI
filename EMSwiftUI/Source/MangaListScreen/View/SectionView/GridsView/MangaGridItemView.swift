//
//  MangaGridItemView.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 06.02.2026.
//
import SwiftUI
import Netify

struct MangaGridItemView: View {
    @ObservedObject var viewModel: MangaGridItemViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            cover

            Text(viewModel.title)
                .font(.SFPro.semiboldNormal)
                .foregroundStyle(Color.blackBase)
                .lineLimit(1)

            RatingView(rating: viewModel.rating)

            Text(viewModel.subtitle)
                .font(.SFPro.lightSmall)
                .foregroundStyle(Color.grayBase)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var cover: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.quaternary)
                
                AsyncImage(url: viewModel.coverURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                        
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.secondary)
                        
                    case .empty:
                        ProgressView()
                        
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(width: 100, height: 144)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
