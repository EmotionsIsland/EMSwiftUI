//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

// MARK: - MainView
struct MainView: View {
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            SearchBarView()
            
            Divider()
            
            MangaSectionTitleView(title: "Popular")
            
            MangaSectionView()
        }
    }
}

#Preview {
    MainView()
}

// MARK: - SearchBarView
struct SearchBarView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.graySearch)
                .frame(height: 36)
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading, 8)

                Text("Search")
                    .font(.custom(FontFamily.SFPro.medium, size: 14))
                
                Spacer()
            }
            .foregroundStyle(.grayBase)
        }
        .padding(.horizontal, 16)
    }
}
