//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    
    @StateObject private var filterViewModel = FilterViewModel()
    
    var body: some View {

        TitleView(title: "Selection")
        
        VStack(alignment: .leading, spacing: 16) {
            FlexibleGridView(filterViewModel: filterViewModel,
                             filters: filterViewModel.selectedFilter,
                             action: { filter in
                filterViewModel.removeFilter(filter)
            })
            
            Spacer()
            
            FiltersButton(filterViewModel: filterViewModel)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(filterViewModel.filterSections, id: \.title) { section in
                    FilterSelectionView(title: section.title,
                                        filters: section.filters,
                                        filterViewModel: filterViewModel
                    )
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    FilterView()
}
