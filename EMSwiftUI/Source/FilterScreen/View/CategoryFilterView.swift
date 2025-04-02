//
//  CategoryFilterView.swift
//  EMSwiftUI
//
//  Created by Антон Баландин on 1.04.25.
//

import SwiftUI

struct CategoryFilterView: View {
    let category: String
    let filters: [String]
    let addFilterAction: (String) -> Void
    let checkPickingAction: (String) -> Bool
    
    @State private var isShowingFilters: Bool = false
    @State private var height: CGFloat = 0
    
    var body: some View {
        VStack {
            categoryButton
            
            if isShowingFilters {
                FlexibleLayout(array: filters) { filter in
                    Button(
                        action: { addFilterAction(filter) },
                        label: {
                            Text(isPicked(filter) ? "+ \(filter)" : filter)
                                .foregroundColor(isPicked(filter) ? Color.whiteText : Color.blackBase)
                                .font(Font.SFPro.bodyNormal)
                        }
                    )
                    .padding(8)
                    .background(isPicked(filter) ? Color.orangeBase : Color.grayBase)
                    .cornerRadius(8)
                }
            }
        }
    }
}

private extension CategoryFilterView {
    private var categoryButton: some View {
        HStack {
            Text(category)
                .font(Font.SFPro.regularLarge)
                .foregroundColor(Color.blackBase)
            Image(systemName: "chevron.down")
                .foregroundColor(.black)
                .rotationEffect(isShowingFilters ? .degrees(180) : .zero)
            Spacer()
        }
        .onTapGesture {
            isShowingFilters.toggle()
        }
    }
    
    private func isPicked(_ filter: String) -> Bool {
        return checkPickingAction(filter)
    }
}
