//
//  ContentView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct ContentView: View {
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
            
            EmptyView()
                .tabItem {
                    Image("book")
                        .renderingMode(.template)
                    Text("Empty")
                        .font(.custom(FontFamily.SFPro.regular, size: 14))
                }
            
            EmptyView()
                .tabItem {
                    Image("person")
                        .renderingMode(.template)
                    Text("Profile")
                        .font(.custom(FontFamily.SFPro.regular, size: 14))
                }
        }
        .accentColor(.orangeBase)
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.grayBase)
        }
    }
}


#Preview {
    ContentView()
}
