//
//  MangaGridItemView.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 06.02.2026.
//
import SwiftUI
import Netify

struct MangaGridItemView: View {
    @ObservedObject var vm: MangaGridItemViewModel

    private let coverHeight: CGFloat = 144
    private let cornerRadius: CGFloat = 12

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            cover

            Text(vm.title)
                .font(.SFPro.semiboldNormal)
                .foregroundStyle(Color.blackBase)
                .lineLimit(1)

            RatingView(rating: vm.rating)

            Text(vm.subtitle)
                .font(.SFPro.lightSmall)
                .foregroundStyle(Color.grayBase)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var cover: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundStyle(.quaternary)
                
                AsyncImage(url: vm.coverURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                        
                    case .failure:
                        Image(systemName: "photo")
                            .foregroundStyle(.secondary)
                        
                    case .empty:
                        EmptyView()
                        
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(width: geometry.size.width)
            .frame(height: coverHeight)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        .frame(height: coverHeight)
    }
}
