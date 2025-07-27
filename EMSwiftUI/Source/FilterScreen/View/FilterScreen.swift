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
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Загрузка тегов...")
                        .padding()
                } else if let error = viewModel.error {
                    Text("Ошибка: \(error.localizedDescription)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    // Секция Selection
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
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // Секции с тегами
                    ForEach(viewModel.sections, id: \.group) { group in
                        FilterSectionView<VM>(section: TagSection(
                            title: group.group,
                            items: group.tags
                        ))
                        .environmentObject(viewModel)
                        .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.vertical)
        }
    }
    
    @ViewBuilder
    var applyButton: some View {
        Button("Apply") {}
        .font(Font.SFPro.mediumNormal)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(Color.orangeBase)
        .cornerRadius(8)
    }
    
    @ViewBuilder
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
