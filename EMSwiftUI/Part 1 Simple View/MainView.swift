//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // TODO: Create main view
            SearchBar()
            Divider()
                .padding(.bottom, 20)
            MangaSectionView(title: "Popular")
            MangaSectionView(title: "Recently Added")
            MangaSectionView(title: "Last Updates")
            MangaSectionView(title: "Seasonal")
        }
    }
}

#Preview {
    MainView()
}
