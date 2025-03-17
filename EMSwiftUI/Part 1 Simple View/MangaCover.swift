//
//  MangaCover.swift
//  EMSwiftUI
//
//  Created by Kristina Grebneva on 17.03.2025.
//

import SwiftUI

struct MangaCover: View {
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizedToFillAndRounded()
        } placeholder: {
            Image(systemName: "book.pages")
                .resizedToFillAndRounded()
        }
    }
}
