//
//  TabBar.swift
//  EMSwiftUI
//
//  Created by Иван Незговоров on 10.12.2024.
//


import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            TabBarItem(icon: Asset.Tabbar.home, title: "Home", selectedTab: $selectedTab, tab: 0)
            Spacer()
            TabBarItem(icon:  Asset.Tabbar.find, title: "", selectedTab: $selectedTab, tab: 1)
            Spacer()
            TabBarItem(icon:  Asset.Tabbar.book, title: "", selectedTab: $selectedTab, tab: 2)
            Spacer()
            TabBarItem(icon:  Asset.Tabbar.profile, title: "", selectedTab: $selectedTab, tab: 3)
        }
        .padding(.top, 8)
    }
}
