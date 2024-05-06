//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = MangaListViewModel(service: MangaListService(network: Network()))
    @State var text = ""
    @State var filtersIsPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack {
                        TextField("Search", text: $text)
                            .padding(10)
                            .background(.gray.opacity(0.3), in: .rect(cornerRadius: 10))
                        
                        Button(action: { filtersIsPresented.toggle() }, label: {
                            Image(systemName: "slider.horizontal.3")
                                .font(.title)
                        })
                    }
                    
                    VStack(spacing: 20) {
                        MangaSectionView(viewModel: vm, title: "Popular")
                        
                        MangaSectionView(viewModel: vm, title: "Recently Added")
                        
                        MangaSectionView(viewModel: vm, title: "Last updates")
                        
                        MangaSectionView(viewModel: vm, title: "Seasonal")
                    }
                }
                .padding()
                
            }
            .navigationTitle("Mangs")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $filtersIsPresented, content: {
                FilterView()
            })
            
        }
    }
}

#Preview {
    MainView()
}
