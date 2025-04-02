//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Factory

struct FilterScreen<VM: FilterScreenViewModel>: View {
    @StateObject private var viewModel: VM
    
    typealias Const = MangaListMainScreenModel.Const
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    Divider()
                    selection
                    Divider()
                    filters
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Const.FilterScreen.navigationTitle)
                        .font(Font.SFPro.headline2)
                }
            }
        }
    }
}

private extension FilterScreen {
    @ViewBuilder
    private var selection: some View {
        if !viewModel.pickedFilters.isEmpty {
            VStack(alignment: .leading) {
                Divider()
                HStack {
                    Text(Const.FilterScreen.sectionName)
                        .font(Font.SFPro.headline3)
                    Spacer()
                }
                
                pickedFilters
                applyButton
                resetButton
            }
        }
    }
    private var pickedFilters: some View {
        FlexibleLayout(array: Array(viewModel.pickedFilters)) { filter in
            Text("+ \(filter)")
                .oranged()
        }
    }
    
    private var applyButton: some View {
        Button(action: {}) {
            Text(Const.FilterScreen.applyButtonName)
                .foregroundColor(Color.whiteText)
                .padding(4)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .font(Font.SFPro.bodyNormal)
        }
        .orangeButtonStyle(color: Color.orangeBase)
    }
    
    private var resetButton: some View {
        Button(action: viewModel.removeAllFilters) {
            Text(Const.FilterScreen.resetButtonName)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.blackBase)
                .contentShape(Rectangle())
                .font(Font.SFPro.bodyNormal)
        }
    }
    
    private var filters: some View {
        VStack(alignment: .leading) {
            ForEach(Array(viewModel.filters.keys.sorted(by: {$0 < $1})), id: \.self) { category in
                OneCategoryFilterView(category: category,
                                      filters: viewModel.filters[category] ?? [],
                                      addFilterAction: viewModel.pickFilter(_:),
                                      checkPickingAction: viewModel.checkPicking(_:)
                )
                .padding(.bottom, 10)
                .font(Font.SFPro.regularLarge)
            }
        }
        .padding(.top, 20)
    }
}

#Preview {
    FilterScreen(viewModel: FilterScreenViewModelImpl(service: MangaListServiceImpl(netify: Container.shared.netify())))
}
