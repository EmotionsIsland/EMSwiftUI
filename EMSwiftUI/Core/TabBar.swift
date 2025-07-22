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

@available(iOS 16.0, *)
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

@available(iOS 16.0, *)
private extension TabBar {
    var mainTab: some View {
        MangaListScreenBuilder.build()
            .tag(TabSelection.main)
            .tabItem {
                Image(.tabBarHome)
            }
    }
    
    var filterTab: some View {
        FilterScreenBuilder.build(tabSelected: $selection)
            .tag(TabSelection.filter)
            .tabItem {
                Image(.tabBarSearch)
            }
    }
}
