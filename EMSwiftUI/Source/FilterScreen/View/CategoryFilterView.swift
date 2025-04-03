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
    
    @State private var isShowingFilters = false
    @State private var height: CGFloat = 0
    
    var body: some View {
        VStack {
            categoryButton
            
            if isShowingFilters {
                FlexibleLayout(array: filters) { tag in
                    Button(
                        action: { addFilterAction(tag) },
                        label: {
                            Text(isPicked(tag) ? "+ \(tag)" : tag)
                                .foregroundColor(isPicked(tag) ? Color.whiteText : Color.blackBase)
                                .font(Font.SFPro.bodyNormal)
                        }
                    )
                    .padding(8)
                    .background(isPicked(tag) ? Color.orangeBase : Color.grayBase)
                    .cornerRadius(8)
                    .transition(.opacity)
                }
            }
        }
        .animation(.default, value: isShowingFilters)
    }
}

private extension CategoryFilterView {
    var categoryButton: some View {
        HStack {
            Text(category)
                .font(Font.SFPro.regularLarge)
                .foregroundColor(Color.blackBase)
            Image(systemName: "chevron.down")
                .foregroundColor(.black)
                .rotationEffect(isShowingFilters ? .degrees(180) : .zero)
                .animation(.easeInOut, value: isShowingFilters)
            Spacer()
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                isShowingFilters.toggle()
            }
        }
    }
    
    func isPicked(_ tag: String) -> Bool {
        checkPickingAction(tag)
    }
}
