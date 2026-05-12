//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Netify

struct MangaSingleGridView: View {
    let item: MangaListItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: API.coverURL(for: item.manga)) { image in
                image
                    .resizedToFill(width: 100, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 100, height: 150)
            }
            
            Text(item.titleText)
                .font(.custom("SFProText-Medium", size: 14))
                .foregroundColor(.blackBase)
                .lineLimit(2)
            
            RatingView(rating: 3.5)
            
            Text(item.tagsText)
                .font(.SFPro.lightSmall)
                .foregroundColor(.gray)
                .lineLimit(1)
                .truncationMode(.tail)
        }
    }
}
