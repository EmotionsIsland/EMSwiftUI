//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: CGFloat
    let maxRating: Int
    
    var body: some View {
        VStack {
            // TODO: Create star rating View
            HStack{
                ForEach(0..<maxRating, id: \.self) { number in
                    if(CGFloat(number) < rating && CGFloat(number+1) > rating){
                        // Половинка звезды
                        ZStack{
                            Asset.Icons.starIcon.swiftUIImage
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray)
                            Asset.Icons.starIcon.swiftUIImage
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.yellow)
                                .clipShape(Rectangle().path(in: CGRect(x: 0, y: 0, width: 7, height: 16)))
                        }
                        
                    }else if (CGFloat(number) < rating){
                        // Заполненная звезда
                        Asset.Icons.starIcon.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.yellow)
                    }else{
                        // Пустая звезда
                        Asset.Icons.starIcon.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gray)
                    }
                }
            }
            .frame(width: 100, height: 16)
        }
    }
}

#Preview {
    RatingView(rating: 4.5, maxRating: 5)
}
