//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct SingleFilters: View {
    @ObservedObject var viewModel: FilterViewModel
    @Binding var selectedFilters: [Filter]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.separatedFilters, id: \.self) { row in
                    HStack(spacing: 10) {
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
            .padding(.horizontal, 16)
        }
    }
}
