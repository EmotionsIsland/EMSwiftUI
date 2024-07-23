//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

enum FilterOptions: String, CaseIterable {
    case contentRating = "Content rating"
    case publicationStatus = "Publication status"
    case magazineDemographic = "Magazine demographic"
    case format = "Format"
    case genre = "Genre"
    case theme = "Theme"
    case none
}

struct FilterView: View {
    @State private var selectedOption: [FilterOptions] = []
    @State var filters = Filter.mockData
    @State var selectedFilters: [Filter] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    titleLabel
                    
                    FiltersGroupView(
                        isSelectedFiltersView: true,
                        filters: $selectedFilters,
                        selectedFilters: $selectedFilters)
                    
                    applyButton
                    
                    resetButton
                    
                    filterSections
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding([.horizontal, .top], 16)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    FilterTitleView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension FilterView {
    var titleLabel: some View {
        HStack {
            Text("Selection")
                .font(FontFamily.SFPro.bold.swiftUIFont(size: 20))
                .foregroundStyle(.blackBase)
                .padding(.vertical)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var applyButton: some View {
        Button(action: {}, label: {
            ZStack {
                Color(.orangeBase)
                    .frame(height: 44)
                    .clipShape(.rect(cornerRadius: 8))
                
                Text("Apply")
                    .font(FontFamily.SFPro.medium.swiftUIFont(size: 20))
                    .foregroundStyle(.white)
            }
        })
    }
    
    var resetButton: some View {
        Button(action: {
            selectedFilters.removeAll()
            filters = filters.map { Filter(name: $0.name, isSelected: false) }
        }, label: {
            ZStack {
                Color(.white)
                    .frame(height: 44)
                    .clipShape(.rect(cornerRadius: 8))
                
                Text("Reset")
                    .font(FontFamily.SFPro.medium.swiftUIFont(size: 20))
                    .foregroundStyle(.blackBase)
            }
        })
    }
    
    var filterSections: some View {
        HStack {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(FilterOptions.allCases.dropLast(), id: \.self) { option in
                    let showOption = selectedOption.contains(option)
                    VStack(alignment: .leading) {
                        FiltersView(title: option.rawValue, isOpened: showOption)
                        if showOption {
                            FiltersGroupView(
                                isSelectedFiltersView: false,
                                filters: $filters,
                                selectedFilters: $selectedFilters)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.smooth) {
                            if selectedOption.contains(option) {
                                selectedOption.remove(at: selectedOption.firstIndex(of: option) ?? 0)
                            } else {
                                selectedOption.append(option)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private extension FilterView {
    func groupFilters(filters: [Filter]) -> [[Filter]] {
        let maxRowLength = UIScreen.main.bounds.width - 35
        var groups: [[Filter]] =  [[]]
        var currentRowLength: CGFloat = 0
        
        for filter in filters {
            if currentRowLength + filterWidth(filter: filter) + 16 >= maxRowLength {
                currentRowLength = filterWidth(filter: filter)
                groups.append([filter])
            } else {
                groups[groups.count - 1].append(filter)
                currentRowLength += filterWidth(filter: filter) + 32
            }
        }
        return groups
    }
    
    func filterWidth(filter: Filter) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 17)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let string = NSAttributedString(string: filter.name, attributes: attributes)
        
        let width = filter.isSelected ?
        string.width(withConstrainedHeight: 0) + 28 :
        string.width(withConstrainedHeight: 0)
        
        return width
    }
}
