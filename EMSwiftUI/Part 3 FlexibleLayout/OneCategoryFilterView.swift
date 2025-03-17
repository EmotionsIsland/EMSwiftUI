//
//  OneCategoryFilterView.swift
//  EMSwiftUI
//
//  Created by Kristina Grebneva on 07.03.2025.
//

import SwiftUI

// структура - вью фильтров одной категории
struct OneCategoryFilterView: View {
    let category: String
    let filters: [String]
    let addFilterAction: (String)->Void
    let checkPickingAction: (String)->Bool
    @State private var isShowingFilters: Bool = false
    @State private var height: CGFloat = 0
    
    typealias Const = MangaListMainScreenModel.Const
    
    var body: some View {
        VStack {
            categoryButton
            
            if isShowingFilters {
                FlexibleLayout(array: filters) {filter in
                    Button(action: { addFilterAction(filter) }) {
                        Text(isPicked(filter) ? "+ \(filter)" : filter)
                    }
                    .orangeButtonStyle(color: isPicked(filter) ? Asset.Colors.orangeBase.swiftUIColor : Asset.Colors.grayBase.swiftUIColor)
                }
            }
        }
    }
}

private extension OneCategoryFilterView {
    private var categoryButton: some View {
        HStack {
            Text(category)
                .font(.custom(FontFamily.SFPro.regular,
                              size: Const.Text.largeSize))
            Asset.Icons.chevron.swiftUIImage
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
