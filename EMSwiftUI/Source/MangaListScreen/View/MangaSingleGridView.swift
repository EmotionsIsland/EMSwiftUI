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
            // Контейнер для изображения с фиксированным соотношением сторон
            Group {
                if let url = coverURL {
                    AsyncImage(url: url) { phase in
                        // Успешная загрузка
                        if case .success(let image) = phase {
                            image
                                .resizable()
                                .scaledToFill()
                        }
                        // Загрузка или ошибка
                        else {
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
            
            // Текстовые элементы
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.blackBase)
                .lineLimit(1)
            
            RatingView()
            
            Text(description)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.grayBase)
                .lineLimit(1)
        }
    }
    
    // Вынесенная заглушка для повторного использования
    private var placeholderView: some View {
        ZStack {
            // Фон заглушки
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.2))
            
            // Иконка или индикатор загрузки
            if coverURL != nil {
                ProgressView() // Показываем при загрузке
            } else {
                Image(systemName: "book.closed.fill") // Показываем если URL нет
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                    .foregroundColor(.gray)
            }
        }
    }
}

//struct MangaSingleGridView: View {
//    let title: String
//    let description: String
//    let coverURL: URL?
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            // Область для изображения с заглушкой
//            ZStack {
//                // Заглушка (показывается всегда под контентом)
//                RoundedRectangle(cornerRadius: 4)
//                    .fill(Color.gray.opacity(0.2))
//                    .aspectRatio(2/3, contentMode: .fit)
//                
//                // Загрузка изображения
//                if let url = coverURL {
//                    AsyncImage(url: url) { phase in
//                        switch phase {
//                        case .empty:
//                            ProgressView() // Индикатор загрузки
//                                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                .background(Color.gray.opacity(0.1))
//                            
//                        case .success(let image):
//                            image
//                                .resizable()
//                                .scaledToFill()
//                                .transition(.opacity.animation(.easeInOut(duration: 0.3)))
//                            
//                        case .failure:
//                            Image(systemName: "book.closed.fill") // Иконка при ошибке
//                                .resizable()
//                                .scaledToFit()
//                                .padding(20)
//                                .foregroundColor(.gray)
//                            
//                        @unknown default:
//                            EmptyView()
//                        }
//                    }
//                    .aspectRatio(2/3, contentMode: .fill)
//                    .clipShape(RoundedRectangle(cornerRadius: 4))
//                } else {
//                    // Если URL нет вообще
//                    Image(systemName: "book.closed.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .padding(20)
//                        .foregroundColor(.gray)
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .aspectRatio(2/3, contentMode: .fit)
//            
//            // Текстовые элементы
//            Text(title)
//                .font(.system(size: 16, weight: .bold))
//                .foregroundColor(.blackBase)
//                .lineLimit(1)
//            
//            RatingView()
//            
//            Text(description)
//                .font(.system(size: 14, weight: .regular))
//                .foregroundColor(.grayBase)
//                .lineLimit(1)
//        }
//    }
//}

//struct MangaSingleGridView: View {
//    let title: String
//    let description: String
//    let coverURL: URL?
//
//    var body: some View {
//        VStack {
//            AsyncImage(url: coverURL) { image in
//                image.image?.resizable().scaledToFill().clipShape(RoundedRectangle(cornerRadius: 4))
//            }
//            
//            Text(title)
//                .font(.system(size: 16, weight: .bold))
//                .foregroundColor(.blackBase)
//                .multilineTextAlignment(.leading)
//                .lineLimit(1)
//            
//            RatingView()
//            
//            Text(description)
//                .font(.system(size: 14, weight: .regular))
//                .foregroundColor(.grayBase)
//                .multilineTextAlignment(.leading)
//                .lineLimit(1)
//        }
//    }
//}

#Preview {
    MangaSingleGridView(title: "Manga Title", description: "Manga Description", coverURL: URL(string: "https://example.com/cover.jpg")!)
}
