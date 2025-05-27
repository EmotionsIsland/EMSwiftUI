//
//  TabBar.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

enum TabSelection {
    case main
    case filter
}

struct TabBar: View {
    @State private var selection: TabSelection = .main
    
    var body: some View {
        TabView(selection: $selection) {
            mainTab
            filterTab
        }
        .tint(.orangeBase)
    }
}

private extension TabBar {
    var mainTab: some View {
        MangaListScreenBuilder.build()
            .tag(TabSelection.main)
            .tabItem {
                Image(.tabBarHome)
            }
    }
    
    var filterTab: some View {
        FilterScreenBuilder.build()
            .tag(TabSelection.filter)
            .tabItem {
                Image(.tabBarSearch)
            }
    }
}
