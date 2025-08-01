//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

enum FilterViewState {
    case loading
    case error(Error)
    case success
}

struct FilterScreen<VM: TagViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var viewState: FilterViewState {
        if viewModel.isLoading {
            return .loading
        } else if let error = viewModel.error {
            return .error(error)
        } else {
            return .success
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                switch viewState {
                case .loading:
                    ProgressView("Загрузка тегов...")
                        .padding()
                case .error(let error):
                    Text("Ошибка: \(error.localizedDescription)")
                        .foregroundColor(.red)
                        .padding()
                case .success:
                    SelectionSectionView(viewModel: viewModel)

                    Divider().padding(.horizontal)

                    TagSectionsView(viewModel: viewModel)
                }
            }
            .padding(.vertical)
        }
    }
}

private struct SelectionSectionView<VM: TagViewModel>: View {
    @ObservedObject var viewModel: VM

    var body: some View {
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

    private var applyButton: some View {
        Button("Apply") { }
        .font(Font.SFPro.mediumNormal)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(Color.orangeBase)
        .cornerRadius(8)
    }

    private var resetButton: some View {
        Button("Reset") {
            viewModel.reset()
        }
        .font(Font.SFPro.mediumNormal)
        .foregroundColor(.blackBase)
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
    }
}

private struct TagSectionsView<VM: TagViewModel>: View {
    @ObservedObject var viewModel: VM

    var body: some View {
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
