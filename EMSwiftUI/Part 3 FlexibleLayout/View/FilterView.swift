//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

// MARK: - FilterView
struct FilterView: View {
    
    @StateObject private var viewModel: FilterViewModel = FilterViewModel(activeFilters: [])
    
    var body: some View {
        VStack {
            SelectionView(viewModel: viewModel)
            
            Divider()
            
            ScrollView {
                ForEach(Section.allCases) { section in
                    SectionView(
                        section: SectionModel(section: section),
                        viewModel: viewModel
                    )
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    FilterView()
}


