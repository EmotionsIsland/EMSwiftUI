//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: FiltersViewModel
    @Binding var filterOptions: [String]
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Spacer(minLength: 0)
                Text("Filters")
                    .font(.custom(FontFamily.SFPro.bold, size: 24))
                Spacer(minLength: 0)
            }
            .frame(height: 30, alignment: .center)
            .overlay(alignment: .trailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 15))
                        .foregroundStyle(.foreground)
                        .padding(.trailing, 16)
                    
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.grayBase)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    selectedFiltersBody
                        .padding(.top, 24)
                    allFiltersBody
                }.padding(.horizontal, 16)
            }
        }
    }
    
    @ViewBuilder
    private var selectedFiltersBody: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Selection")
                .font(.custom(FontFamily.SFPro.bold, size: 20))
            
            if filterOptions == [] {
                Text("No filters selected")
                    .font(.custom(FontFamily.SFPro.regular, size: 16))
                    .transition(.move(edge: .leading))
            } else {
                FilterOptionsGridView(selectedOptions: $filterOptions, availibleOptions: filterOptions)
                    .transition(.move(edge: .trailing))
            }
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Spacer(minLength: 0)
                    Text("Apply")
                        .font(.custom(FontFamily.SFPro.semibold, size: 16))
                        .padding(.vertical, 14)
                        .foregroundStyle(.background)
                    Spacer(minLength: 0)
                }
                .background(.orangeBase, in: .rect(cornerRadius: 8))
            }
            
            Button {
                filterOptions = []
            } label: {
                HStack {
                    Spacer(minLength: 0)
                    Text("Reset")
                        .font(.custom(FontFamily.SFPro.semibold, size: 16))
                        .padding(.vertical, 2)
                        .foregroundStyle(.foreground)
                    Spacer(minLength: 0)
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.whiteText)
        }
    }
    
    @ViewBuilder
    private var allFiltersBody: some View {
        FilterSectionView(selectedOptions: $filterOptions,
                          availibleOptions: viewModel.filtersList?.contentRatings ?? [],
                          sectionName: "Content Rating")
        
        FilterSectionView(selectedOptions: $filterOptions,
                          availibleOptions: viewModel.filtersList?.publicationStatuses ?? [],
                          sectionName: "Publication Status")
        
        FilterSectionView(selectedOptions: $filterOptions,
                          availibleOptions: viewModel.filtersList?.magazineDemographics ?? [],
                          sectionName: "Magazine Demographic")
        
        FilterSectionView(selectedOptions: $filterOptions,
                          availibleOptions: viewModel.filtersList?.formats ?? [],
                          sectionName: "Format")
        
        FilterSectionView(selectedOptions: $filterOptions,
                          availibleOptions: viewModel.filtersList?.genres ?? [],
                          sectionName: "Genre")
        
        FilterSectionView(selectedOptions: $filterOptions,
                          availibleOptions: viewModel.filtersList?.themes ?? [],
                          sectionName: "Theme")
    }
}

#Preview {
    FilterView(filterOptions: .constant(["Shounen", "Shoujo", "Seinen", "Josei", "None", "Any"]))
        .environmentObject(FiltersViewModel(service: MangaListService(network: Network())))
}
