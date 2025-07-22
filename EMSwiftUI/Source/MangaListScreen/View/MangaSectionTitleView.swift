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
                .background(Color.gray.opacity(0.1))
                .overlay(
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                )
                .background(Color.init(cgColor: #colorLiteral(red: 0.9294117689, green: 0.9333333373, blue: 0.9490196705, alpha: 1)))
                .cornerRadius(8)
                .padding(.horizontal)
            Divider()
                .padding(.top, 16)
                .foregroundStyle(Color.init(cgColor: #colorLiteral(red: 0.7686275244, green: 0.7686275244, blue: 0.7686275244, alpha: 1)))
                .frame(height: 1)
        }
    }
}

#Preview {
    MangaSectionTitleView()
}
