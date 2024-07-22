//
//  FilterGroupView.swift
//  EMSwiftUI
//
//  Created by Никита Гладышев on 21.07.2024.
//

import SwiftUI

struct FiltersGroupView: View {
    let isSelectedFiltersView: Bool
    @Binding var filters: [Filter]
    @Binding var selectedFilters: [Filter]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(groupFilters(filters: filters), id: \.self) { group in
                HStack(spacing: 8) {
                    ForEach(group.indices, id: \.self) { index in
                        let isSelected = group[index].isSelected
                        ZStack {
                            Color(isSelected ? .orangeBase : .grayBase)
                                .clipShape(.rect(cornerRadius: 8))
                                .frame(width: filterWidth(filter: group[index]) + 16, height: 36)
                                .onTapGesture {
                                    if !isSelectedFiltersView {
                                        if dublicateFilter(with: group[index]) {
                                            selectedFilters.append(group[index])
                                        } else {
                                            selectedFilters.remove(at: indexOf(group[index]))
                                        }
                                        group[index].isSelected.toggle()
                                        updateFilters(with: group[index])
                                    }
                                }
                            
                            HStack(alignment: .center, spacing: 8) {
                                if isSelected {
                                    Image(systemName: "plus")
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.white)
                                }
                                Text(group[index].name)
                                    .font(.system(size: 17))
                                    .foregroundColor(group[index].isSelected ? .white : .black)
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32)
    }
}

private extension FiltersGroupView {
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

    func updateFilters(with filter: Filter) {
        guard let index = filters.firstIndex(of: filter) else { return }
        let filter = Filter(name: filters[index].name, isSelected: filter.isSelected)
        filters[index] = filter
    }
    
    func dublicateFilter(with filter: Filter) -> Bool {
        for selectedFilter in selectedFilters {
            if selectedFilter.name == filter.name {
                return false
            }
        }
        return true
    }

    func indexOf(_ filter: Filter) -> Int {
        var index = 0
        for selectedFilter in selectedFilters {
            if selectedFilter.name == filter.name {
                return index
            } else {
                index += 1
            }
        }
        return index
    }
}
