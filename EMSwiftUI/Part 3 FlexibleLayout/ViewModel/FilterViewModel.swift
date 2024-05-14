//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by User on 14.05.2024.
//

import SwiftUI

final class FilterViewModel: ObservableObject {
    @Published var filters: [Filter]
    private let spacing: CGFloat = 10
    private let horizontalPadding: CGFloat = 33.5
    
    lazy var separatedFilters: [[Filter]] = {
        divideFiltersIntoRows(filters: filters)
    }()
    
    // MARK: - Initialization
    init(filters: [Filter]) {
        self.filters = filters
    }
}

// MARK: - Private methods
private extension FilterViewModel {
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
