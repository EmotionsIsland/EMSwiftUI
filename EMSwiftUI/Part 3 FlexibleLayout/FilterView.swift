//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @StateObject private var filtersViewModel = FilterViewModel()
    
    typealias Const = MangaListMainScreenModel.Const
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    selection
                    Divider()
                    filters
                    Spacer()
                }
            }
            .padding()
            .navigationTitle(Const.FilterScreen.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: { Asset.Icons.back.swiftUIImage })
            }
        }
    }
}

private extension FilterView {
    @ViewBuilder
    private var selection: some View {
        if filtersViewModel.pickedFilters.isNotEmpty {
            VStack(alignment: .leading) {
                Divider()
                HStack {
                    Text(Const.FilterScreen.sectionName)
                        .font(.custom(FontFamily.SFPro.bold,
                                      size: Const.Text.largeSize))
                    Spacer()
                }
                
                pickedFilters
                    .padding(Const.Layout.smallPadding)
                
                applyButton
                resetButton
            }
        }
    }
    
    private var pickedFilters: some View {
        FlexibleLayout(array: Array(filtersViewModel.pickedFilters)) { filter in
            Text("+ \(filter)")
                .oranged()
        }
    }
    
    private var applyButton: some View {
        Button(action: {}) {
            Text(Const.FilterScreen.applyButtonName)
                .padding(Const.Layout.smallPadding)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .orangeButtonStyle(color: Asset.Colors.orangeBase.swiftUIColor)
    }
    
    private var resetButton: some View {
        Button(action: filtersViewModel.removeAllFilters) {
            Text(Const.FilterScreen.resetButtonName)
                .padding(Const.Layout.smallPadding)
                .frame(maxWidth: .infinity)
                .foregroundColor(Asset.Colors.blackBase.swiftUIColor)
                .contentShape(Rectangle())
        }
    }
    
    private var filters: some View {
        VStack(alignment: .leading) {
            ForEach(Array(filtersViewModel.filters.keys.sorted(by: {$0 < $1})), id: \.self) { category in
                OneCategoryFilterView(category: category,
                                      filters: filtersViewModel.filters[category] ?? [],
                                      addFilterAction: filtersViewModel.pickFilter(_:),
                                      checkPickingAction: filtersViewModel.checkPicking(_:)
                )
            }
        }
    }
}

