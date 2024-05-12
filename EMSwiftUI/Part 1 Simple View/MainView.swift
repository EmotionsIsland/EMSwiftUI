//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @State private var searchQuery = ""
    @State private var filterOpened = false
    @State private var filterOptions: [String] = []
    
    private let sections = ["Popular","Recently Added","Last Updates","Seasonal"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 8) {
                        CustomizedTextField(
                            text: $searchQuery,
                            placeholder: "Search",
                            placeholderImage: .searchIcon
                        )
                        
                        CustomizedButton(image: .filterIcon) {
                            filterOpened.toggle()
                        }
                    }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.grayBase)
                }
                    .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(sections, id: \.self) { sectionName in
                        MangaSectionView(sectionName: LocalizedStringKey(stringLiteral: sectionName))
                    }
                }
                    .padding(.horizontal, 16)
            }
        }
        .fullScreenCover(isPresented: $filterOpened) {
            FilterView(filterOptions: $filterOptions)
        }
    }
}

#Preview {
    MainView()
        .environmentObject(MangaListViewModel(service: MangaListService(network: Network())))
        .environmentObject(FiltersViewModel(service: MangaListService(network: Network())))
}
