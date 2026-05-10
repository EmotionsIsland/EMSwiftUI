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
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            TabBarHeaderView(selection: selection, searchText: $searchText)
            Divider()
            
            TabView(selection: $selection) {
                mainTab
                filterTab
            }
        }
        .tint(.orangeBase)
    }
}

private extension TabBar {
    var mainTab: some View {
        MangaListScreenBuilder.build(searchText: $searchText)
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

private struct TabBarHeaderView: View {
    let selection: TabSelection
    @Binding var searchText: String
    
    var body: some View {
        switch selection {
        case .main:
            SearchHeaderView(text: $searchText)
        case .filter:
            Text("Filters")
                .font(.SFPro.headline3)
                .foregroundColor(.blackBase)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(.white)
        }
    }
}

private struct SearchHeaderView: View {
    @Binding var text: String
    private let placeholderOpacity = 0.5
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Image(.search)
                    .renderingMode(.template)
                    .foregroundStyle(.blackBase)
                    .opacity(placeholderOpacity)
                
                TextField(
                    "",
                    text: $text,
                    prompt: Text("Search")
                        .font(.SFPro.bodyNormal)
                        .foregroundColor(.blackBase.opacity(placeholderOpacity))
                )
                    .font(.SFPro.bodyNormal)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, minHeight: 36)
            .background(.grayBase)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.white)
    }
}
