//
//  MangaCoverView.swift
//  EMSwiftUI
//
//  Created by mm pechenbku on 05.06.2025.
//

import SwiftUI

struct MangaCoverView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
        } placeholder: {
            ShimmerView(view: Color.grayBase)
        }
        .aspectRatio(100 / 144, contentMode: .fill)
        .clipShape(.rect(cornerRadius: 4))
    }
}
