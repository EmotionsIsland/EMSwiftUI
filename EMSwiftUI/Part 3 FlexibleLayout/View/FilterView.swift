//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var viewModel: FilterViewModel
    
    var body: some View {
        VStack {
            SelectionView(selectedTags: viewModel.selectedTags)
                .environmentObject(viewModel)
            
            buttonsView
            
            Divider()
            
            ScrollView {
                ForEach(FilterType.allCases, id: \.self) { filter in
                    FilterTypeView(
                        filter: filter,
                        tags: viewModel.tags[filter] ?? []
                    )
                }
            }
        }
        .padding()
    }
}

private extension FilterView {
    var buttonsView: some View {
        VStack {
            Button("Apply", action: applyFilters)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.orangeBase)
                .foregroundColor(.white)
                .cornerRadius(8)
                .font(.custom(FontFamily.SFPro.medium, size: 16))
            
            Button("Reset", action: resetFilters)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .foregroundColor(.blackBase)
                .cornerRadius(8)
                .font(.custom(FontFamily.SFPro.medium, size: 16))
            
        }
    }
    
    func applyFilters() {
        viewModel.applyFilterTapped()
    }
    
    func resetFilters() {
        viewModel.resetFilterTapped()
    }
}
