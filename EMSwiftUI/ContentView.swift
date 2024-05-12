import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView {
                MainView()
                    .tabItem { Label("Home", systemImage: "house.fill") }
                FilterView()
                    .tabItem { Label("Search", systemImage: "magnifyingglass") }
            }
        }
    }
}
