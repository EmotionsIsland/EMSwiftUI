//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    
    private let titles: [String] = ["Popular", "Recently Added", "Last Updates", "Seasonal"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // TODO: Create main view
            SearchBar()
            Divider()
                .padding(.bottom, 20)
            ForEach(titles, id: \.self){ title in
                MangaSectionView(title: title)
            }
        }
    }
}

#Preview {
    MainView()
}
