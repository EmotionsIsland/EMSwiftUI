//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {

    let rating = 3.2

    @ObservedObject var mangaListViewModel: MangaListViewModel

    let mangaData: MangaData
    let imageURL: URL

    var body: some View {
        VStack {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 144)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                @unknown default:
                    EmptyView()
                }
            }
            let title = mangaData.attributes.title.en ?? mangaData.attributes.altTitles.first?.en ?? ""
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .frame(width: 100, height: 20, alignment: .leading )

            RatingView(rating: rating)

            let genre = mangaData.attributes.tags.first(where: { $0.attributes.group == "genre" })?.attributes.name.en ?? ""
            Text(genre)
                .font(.system(size: 14, weight: .light))
                .frame(width: 100, height: 20, alignment: .leading )
                .foregroundStyle(.grayBase)
        }
    }
}

//#Preview {
//    MangaSingleGridView(mangaListViewModel: <#MangaListViewModel#>, mangaData: <#MangaData#>, imageURL: <#URL#>mangaListViewModel:
//}
