//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {

    let image: String = "53"
    let title: String = "Temporary title"
    let rating: Int = 4
    let genre: String = "Some genre"

    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: image)!)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 144)
                .clipShape(.rect(cornerRadius: 8))

            Text(title)
                .font(.system(size: 14, weight: .bold))
                .frame(width: 100, height: 20, alignment: .leading )

            RatingView(rating: 4)

            Text(genre)
                .font(.system(size: 14, weight: .light))
                .frame(width: 100, height: 20, alignment: .leading )
                .foregroundStyle(.grayBase)
        }
    }
}

#Preview {
    MangaSingleGridView()
}
