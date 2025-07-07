//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen<VM: FilterScreenViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                makeScreenHeader()
                
                makeSelectionSection()
                
                makeApplyButton()
                
                makeResetButton()
                
                makeSections()
            }
            .padding(.horizontal, 10)
            .alert(isPresented: $viewModel.showError, error: ViewModelError.failedToLoadTags) {
                Button("Ok") {
                }
            }
    }
}

private extension FilterScreen {
    @ViewBuilder func makeSelectionSection() -> some View {
        VStack {
            HStack {
                Text("Selection")
                    .font(Font.SFPro.headline2)
                    .foregroundStyle(.blackBase)
                
                Spacer()
            }
                TagListView(tags: viewModel.selectedTags, spacing: 5) { id, bool in
                    viewModel.didTapOnTag(tagId: id, isSelected: bool)
            }
        }
    }
    
    @ViewBuilder func makeApplyButton() -> some View {
        Button {
        } label: {
            Text("Apply")
                .font(Font.SFPro.bodyNormal)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.orangeBase)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    @ViewBuilder func makeResetButton() -> some View {
        Button {
            viewModel.reset()
        } label: {
            Text("Reset")
                .font(Font.SFPro.bodyNormal)
                .foregroundStyle(.black)
        }
    }
    
    @ViewBuilder func makeSections() -> some View {
            let action = viewModel.didTapOnTag
                FilterExpandableSection(
                    name: "Content",
                    action: action,
                    tags: viewModel.filterForSection(group: .content))
                
                FilterExpandableSection(
                    name: "Format",
                    action: action,
                    tags: viewModel.filterForSection(group: .format))
                
                FilterExpandableSection(
                    name: "Genre",
                    action: action,
                    tags: viewModel.filterForSection(group: .genre))
                
                FilterExpandableSection(
                    name: "Format",
                    action: action,
                    tags: viewModel.filterForSection(group: .format))
    }
    
    @ViewBuilder func makeScreenHeader() -> some View {
        VStack {
            Text("Filters")
                .font(Font.SFPro.headline2)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay {
                    HStack {
                        Spacer()
                        
                        Image(uiImage: .close)
                            .padding(.trailing, 10)
                    }
                }
            
            Divider()
        }
    }
}
