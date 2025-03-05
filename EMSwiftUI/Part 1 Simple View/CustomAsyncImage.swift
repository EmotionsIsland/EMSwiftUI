//
//  CustomAsyncImage.swift
//  EMSwiftUI
//
//  Created by Гриша Шкробов on 05.03.2025.
//

import SwiftUI

struct CustomAsyncImage: View {
    
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url){ phase in
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
    }
}

#Preview {
    CustomAsyncImage(url: URL(string: ""))
}
