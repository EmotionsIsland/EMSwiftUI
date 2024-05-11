//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct Filter: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct Filters: View {
    private let spacing: CGFloat = 10
    private let horizontalPadding: CGFloat = 16
    let filters: [Filter]
    
    @Binding var selectedFilters: [Filter]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing) {
                ForEach(divideFiltersIntoRows(filters: filters), id: \.self) { row in
                    HStack(spacing: spacing) {
                        ForEach(row) { filter in
                            let buttonText = !selectedFilters.contains(filter) ? filter.name : "+ \(filter.name)"
                            Text(buttonText)
                                .padding(5)
                                .background(selectedFilters.contains(filter) ? Color.orangeBase : Color.grayBase)
                                .foregroundColor(selectedFilters.contains(filter) ? .white : .black)
                                .cornerRadius(5)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .lineLimit(1)
                                .onTapGesture {
                                    if selectedFilters.contains(filter) {
                                        let index = selectedFilters.firstIndex(of: filter)
                                        selectedFilters.remove(at: index ?? 0)
                                    } else {
                                        selectedFilters.append(filter)
                                    }
                                }
                        }
                    }
                }
            }
            .padding(.horizontal, horizontalPadding)
        }
    }
}

private extension Filters {
    func divideFiltersIntoRows(filters: [Filter]) -> [[Filter]] {
        var rows: [[Filter]] = [[]]
        var currentRowWidth: CGFloat = 0
        
        for filter in filters {
            let filterWidth = getTextWidth(text: filter.name)
            if currentRowWidth + filterWidth <= UIScreen.main.bounds.width - (2 * horizontalPadding) {
                rows[rows.count - 1].append(filter)
                currentRowWidth += filterWidth + spacing
            } else {
                rows.append([filter])
                currentRowWidth = filterWidth + spacing
            }
        }
        
        return rows
    }
    
    func getTextWidth(text: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 17)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size.width + 10
    }
}
