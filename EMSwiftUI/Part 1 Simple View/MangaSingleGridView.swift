//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    
    @State var mangaData: MangaData
    let mangaListViewModel: MangaListViewModel
    
    var body: some View {
        Button(action: {
            mangaWasTapped()
        }, label: {
            VStack {
                // TODO: Create single grid View
    //            Image("example_1")
    //                .resizable()
    //                .scaledToFit()
    //                .frame(width: 100, height: 144)
                    
                AsyncImage(url: mangaListViewModel.getCoverURL(manga: mangaData, sizeFormat: .size256)){ phase in
                    switch phase {
                        case .empty:
                            // Показываем индикатор загрузки
                            ProgressView()

                        case .success(let image):
                            // Отображаем загруженное изображение
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(5)

                        case .failure:
                            // Показываем изображение-ошибку
                            Image(systemName: "xmark.octagon")
                                .foregroundColor(.red)
                                .font(.largeTitle)

                        @unknown default:
                            EmptyView()
                        }
                }
                .frame(width: 100, height: 144)
                
                VStack(alignment: .leading) {
                    Text(getTitle())
                        .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                        .font(.custom(FontFamily.SFPro.semibold, size: 16))
                        .lineLimit(1)
                    RatingView(rating: CGFloat.random(in: 0...5), maxRating: 5)
                    Text(getTags())
                        .foregroundStyle(Color(red: 196/255, green: 196/255, blue: 196/255))
                        .font(.custom(FontFamily.SFPro.light, size: 14))
                        .lineLimit(1)
                }
                .frame(width: 100, height: 66)
            }
            .frame(width: 100, height: 210)
        })
    }
    
    private func getTitle() -> String {
        if let title = mangaData.attributes.title.en {
            return title
        }else if let title = mangaData.attributes.altTitles.first(where: { altTitle in
            altTitle.ru != nil
        })?.ru {
            return title
        }else{
            return "No name"
        }
    }
    
    private func getTags() -> String {
        let tags = mangaData.attributes.tags.compactMap(\.self.attributes.name.en).joined(separator: ", ")
        return tags
    }
    
    private func mangaWasTapped(){
        
    }
}

#Preview {
    MangaSingleGridView(mangaData: .mock, mangaListViewModel: MangaListViewModel(mangaService: MangaListService(network: Network())))
}
