//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @State private var searchManga = ""

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                MangaSectionView(sectionTitle: Const.Layout.popularSectionTitle)
                
                MangaSectionView(sectionTitle: Const.Layout.recentlyAddedSectionTitle)
                
                MangaSectionView(sectionTitle: Const.Layout.lastUpdatesSectionTitle)
                
                MangaSectionView(sectionTitle: Const.Layout.seasonalSectionTitle)
            }
        }
        .searchable(text: $searchManga)
    }
}

#Preview {
    MainView()
}
