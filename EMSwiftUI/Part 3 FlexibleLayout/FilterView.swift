//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @StateObject private var viewModel = FilterViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    headerView
                    applyButton
                    resetButton
                    expandableView
                    Divider()
                }
                .padding(.horizontal)
                Spacer()
            }
        }
    }
}

private extension FilterView {
    
    var headerView: some View {
        Group {
            Text("Selection")
                .font(.custom(FontFamily.SFPro.bold, size: 20))
            if !viewModel.selectedTags.isEmpty {
                WrappingStack(items: viewModel.selectedTags, spacing: 8, singleItemHeight: 20) { tag in
                    TagView(tag: tag, viewModel: viewModel)
                }
            }
        }
    }
    var expandableView: some View {
        VStack {
            ForEach(viewModel.tags, id: \.id) { collection in
                EMSwiftUI.ExpandableView(tags: viewModel.tags, title: collection.attributes?.name.en ?? "", viewModel: viewModel)
            }
        }
        .padding(.horizontal)
    }
    
    var applyButton: some View {
        Button {} label: {
            Text("Apply")
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(.orangeBase)
                .cornerRadius(10)
                .foregroundStyle(.white)
        }
    }
    
    var resetButton: some View {
        Button {} label: {
            HStack {
                Spacer()
                Text("Reset")
                    .foregroundStyle(.black)
                    .onTapGesture {
                        viewModel.resetTags()
                    }
                Spacer()
            }
        }
    }
}
