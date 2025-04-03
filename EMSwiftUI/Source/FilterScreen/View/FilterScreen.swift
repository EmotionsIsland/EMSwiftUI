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
                    categories
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Strings.filters)
                        .font(Font.SFPro.headline2)
                }
            }
        }
    }
}

private extension FilterScreen {
    @ViewBuilder
    private var selection: some View {
        if !viewModel.selectedTags.isEmpty {
            VStack(alignment: .leading) {
                Divider()
                HStack {
                    Text(Strings.selection)
                        .font(Font.SFPro.headline3)
                    Spacer()
                }
                selectedTags
                applyButton
                resetButton
            }
        }
    }
    
    private var selectedTags: some View {
        FlexibleLayout(array: Array(viewModel.selectedTags)) { tag in
            Text("+ \(tag)")
                .foregroundColor(Color.whiteText)
                .font(Font.SFPro.bodyNormal)
                .padding(8)
                .background(Color.orangeBase)
                .cornerRadius(8)
        }
    }
    
    private var applyButton: some View {
        Button(
            action: {},
            label: {
                Text(Strings.apply)
                    .foregroundColor(Color.whiteText)
                    .padding(4)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .font(Font.SFPro.bodyNormal)
            }
        )
        .padding(8)
        .background(Color.orangeBase)
        .cornerRadius(8)
    }
    
    private var resetButton: some View {
        Button(action: viewModel.removeAllSelectedTags) {
            Text(Strings.reset)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.blackBase)
                .contentShape(Rectangle())
                .font(Font.SFPro.bodyNormal)
        }
    }
    
    private var categories: some View {
        VStack(alignment: .leading) {
            ForEach(Array(viewModel.tagDictionary.keys.sorted(by: {$0 < $1})), id: \.self) { category in
                CategoryFilterView(category: category,
                                   filters: viewModel.tagDictionary[category] ?? [],
                                   addFilterAction: viewModel.addTag(_:),
                                   checkPickingAction: viewModel.isSelected(_:)
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
