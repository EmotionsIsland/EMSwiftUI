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
                .padding(.leading, 24)
                .padding(8)
                .background(Color.whiteText)
                .overlay(
                    Image(.search)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 4)
                )
                .cornerRadius(8)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            Divider()
                .frame(height: 1)
                .foregroundStyle(Color.grayBase)
        }
    }
}
#Preview {
    MangaSectionTitleView()
}
