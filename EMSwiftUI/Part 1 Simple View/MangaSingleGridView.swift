//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    
    var mangaImage: UIImage?

    var body: some View {
        VStack {
            Image(uiImage: mangaImage ?? UIImage()).resizedToFill(width: 100, height: 144)
            
            Text("Placeholder text")
                .frame(maxWidth: 100, alignment: .leading)
                .font(.custom(FontFamily.SFPro.semibold, size: 16))
            
            RatingView(
                rating: 3.3,
                maxRating: 5
            )
            
            Text("Action")
                .frame(maxWidth: 100, alignment: .leading)
                .font(.custom(FontFamily.SFPro.light, size: 14))
                .foregroundStyle(.grayBase)
        }
        .frame(width: 100, height: 208)
    }
}
