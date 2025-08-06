//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: TagViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            switch viewModel.viewState {
            case .loading:
                ProgressView("Загрузка тегов...")
                    .padding()
            case .error(let error):
                Text("Ошибка: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            case .success:
                VStack(alignment: .leading, spacing: 20) {
                    selectionSectionView()
                    
                    Divider().padding(.horizontal)
                    
                    ForEach(viewModel.sections, id: \.group) { group in
                        FilterSectionView<VM>(
                            section: TagSection(
                                title: group.group,
                                items: group.tags
                            ),
                            viewModel: viewModel
                        )
                        .padding(.horizontal, 16)
                    }
                } .padding(.vertical)
            }
        }
    }
}

private extension FilterScreen {
    @ViewBuilder
    func selectionSectionView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Selection")
                .font(Font.SFPro.headline3)

            if viewModel.selectedTags.isEmpty {
                Text("Нет выбранных тегов")
                    .font(Font.SFPro.lightSmall)
                    .foregroundColor(.grayBase)
            } else {
                FlexibleTagGrid(tags: viewModel.selectedTags)
            }

            Spacer().frame(height: 2)

            applyButton
            resetButton
        }
        .padding(.horizontal, 16)
    }
    
    var applyButton: some View {
        Button("Apply") { }
        .font(Font.SFPro.mediumNormal)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(Color.orangeBase)
        .cornerRadius(8)
    }

    var resetButton: some View {
        Button("Reset") {
            viewModel.reset()
        }
        .font(Font.SFPro.mediumNormal)
        .foregroundColor(.blackBase)
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
    }
}
