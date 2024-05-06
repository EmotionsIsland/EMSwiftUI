//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var selectedFilters: [String] = []
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    selectionView()
                    
                    allFiltersView()
                }
                .padding()
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

private extension FilterView {
    func selectionView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Selection")
                .font(.title3)
                .bold()
            
            if selectedFilters.isEmpty {
                Text("Filter list is empty")
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                TagsView(selectedTags: $selectedFilters, allTags: nil)
            }
            
            Button(action: {  }) {
                Text("Apply")
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(.orange, in: .rect(cornerRadius: 8))
            }
            
            Button(action: { selectedFilters.removeAll() }) {
                Text("Reset")
                    .bold()
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    func allFiltersView() -> some View {
        VStack(spacing: 30) {
            FilterSectionView(selectedFilters: $selectedFilters,
                              title: "Content Rating",
                              allFilters: MangaFilter.ContentRating.allCases.map { $0.rawValue })
            
            FilterSectionView(selectedFilters: $selectedFilters,
                              title: "Publication Status",
                              allFilters: MangaFilter.PublicationStatus.allCases.map { $0.rawValue })
        }
    }
    
}
