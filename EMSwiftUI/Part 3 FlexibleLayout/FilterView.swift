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
    @State private var selectedOption: FilterOptions = .none
    @State var filters = [Filter(name: "Shounen", isSelected: false),
                   Filter(name: "Shoujo", isSelected: false),
                   Filter(name: "Sheinen", isSelected: false),
                   Filter(name: "Josei", isSelected: false),
                   Filter(name: "Nonse", isSelected: false),
                   Filter(name: "Search", isSelected: false),
                   Filter(name: "Very long filter", isSelected: false),
                   Filter(name: "Filter tt", isSelected: false),
                   Filter(name: "Another very long filter", isSelected: false),
                   Filter(name: "Note", isSelected: false)]
    
    @State var selectedFilters: [Filter] = []

    var body: some View {
        VStack {
            FilterTitleView()
            
            HStack {
                Text("Selection")
                    .font(FontFamily.SFPro.bold.swiftUIFont(size: 20))
                    .foregroundStyle(.blackBase)
                    .padding(.vertical)
                
                Spacer()
            }
            
            FiltersGroupView(
                isSelectedFiltersView: true,
                filters: $selectedFilters,
                selectedFilters: $selectedFilters)
            
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
            
            HStack {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(FilterOptions.allCases.dropLast(), id: \.self) { option in
                        let showOption = selectedOption == option
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
                                if selectedOption == option {
                                    selectedOption = .none
                                } else {
                                    selectedOption = option
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    private func groupFilters(filters: [Filter]) -> [[Filter]] {
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
    
    private func filterWidth(filter: Filter) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 17)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let string = NSAttributedString(string: filter.name, attributes: attributes)
        
        let width = filter.isSelected ?
        string.width(withConstrainedHeight: 0) + 28 :
        string.width(withConstrainedHeight: 0)
        
        return width
    }
}

struct FiltersView: View {
    let title: String
    let isOpened: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(FontFamily.SFPro.regular.swiftUIFont(fixedSize: 20))
                .foregroundStyle(.blackBase)
            
            Image(systemName: isOpened ? "chevron.up" : "chevron.down")
                .resizable()
                .frame(width: 12, height: 6)
                .foregroundStyle(.blackBase)
        }
    }
}

struct MockButton: View {
    var body: some View {
        Button {
        } label: {
            Text("Tap on me")
                .background(.orangeBase)
        }
    }
}
