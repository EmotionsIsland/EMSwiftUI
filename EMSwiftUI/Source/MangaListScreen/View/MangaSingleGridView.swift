//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let title: String
    let description: String
    let coverURL: URL?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            MangaCoverImage(url: coverURL)
                .aspectRatio(2/3, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .frame(maxWidth: .infinity)
            
            Text(title)
                .font(Font.SFPro.mediumNormal)
                .foregroundColor(.blackBase)
                .lineLimit(1)
            
            RatingView()
            
            Text(description)
                .font(Font.SFPro.lightSmall)
                .foregroundColor(.grayBase)
                .lineLimit(1)
        }
    }
}
