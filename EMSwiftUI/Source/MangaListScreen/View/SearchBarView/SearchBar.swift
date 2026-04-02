//
//  SearchBar.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 29.01.2026.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        HStack {
            Image("search")
                .foregroundColor(.gray)

            TextField("Search", text: $searchText)
                .foregroundColor(Color.grayBase)
                .font(.SFPro.lightSmall)
                .disableAutocorrection(true)
                .focused($isSearchFocused)
                .onSubmit {
                    isSearchFocused = false
                }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
    }
}
