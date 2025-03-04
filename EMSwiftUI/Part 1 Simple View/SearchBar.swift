//
//  SearchBar.swift
//  EMSwiftUI
//
//  Created by Гриша Шкробов on 04.03.2025.
//

import SwiftUI

struct SearchBar: View {
    
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.grayBase)
            // Поле для ввода текста
            TextField("Search", text: $searchText)
               .padding(.horizontal, 5)
       }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

#Preview {
    SearchBar()
}
