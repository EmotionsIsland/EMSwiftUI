//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("Search", text: $searchText)
                .padding(.leading, 30)
                .padding(8)
                .background(Color.grayBase)
                .overlay(
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                )
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.bottom, 16)
            Divider()
                .frame(height: 1)
                .foregroundStyle(Color.grayBase)
        }
    }
}

#Preview {
    MangaSectionTitleView()
}
