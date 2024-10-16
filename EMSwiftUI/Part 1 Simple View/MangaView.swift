//
//  MangaView.swift
//  EMSwiftUI
//
//  Created by Денис Хафизов on 13.10.2024.
//

import SwiftUI
struct MangaView: View {
    let title: String
    let items: [MangaData]
    
    var body: some View {
        
        VStack {
            MangaSectionTitleView(title: title)
                .padding(.horizontal)
                .padding(.top, 24)
            
            if !items.isEmpty {
                MangaSingleGridView(items: items)
            } else {
                ProgressView("Loading...")
            }
        }
    }
}
