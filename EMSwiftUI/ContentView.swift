//
//  ContentView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = .grayBase
    }
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image("home")
                        .renderingMode(.template)
                    Text("Home")
                        .font(.custom(FontFamily.SFPro.regular, size: 14))
                }
            
            FilterView()
                .tabItem {
                    Image("search")
                        .renderingMode(.template)
                    Text("Filter")
                        .font(.custom(FontFamily.SFPro.regular, size: 14))
                }
            
            FirstMockScreen()
                .tabItem {
                    Image("book")
                        .renderingMode(.template)
                    Text("Book")
                        .font(.custom(FontFamily.SFPro.regular, size: 14))
                }
            
            SecondMockScreen()
                .tabItem {
                    Image("person")
                        .renderingMode(.template)
                    Text("Profile")
                        .font(.custom(FontFamily.SFPro.regular, size: 14))
                }
        }
        .accentColor(.orangeBase)
    }
}
