//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = FilterViewModel()
    
    var body: some View {
        Divider()
        mainView
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
    }
}
private extension FilterView {
    var mainView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Selection")
                    .font(FontFamily.SFProText.bold.swiftUIFont(fixedSize: 20))
                
                TagLayoutView(
                    selectedTags: $viewModel.selectedTags
                ) { selectTag in
                    viewModel.removeTag(selectTag, needDeletePlus: true)
                }
                
                buttonsView
                Divider()
                    .padding(.vertical)
                ForEach(viewModel.sections.indices, id: \.self) { index in
                    CollapsibleSection(
                        title: viewModel.sections[index].text,
                        tags: $viewModel.sections[index].isSelect,
                        onSelect: { tag in
                            tag.select ? viewModel.addTag(tag, needDeletePlus: false): viewModel.removeTag(tag, needDeletePlus: false)
                        }
                    )
                    .padding(.bottom, 13)
                }
            }
            .padding()
        }
    }
    
    var buttonsView: some View {
        VStack {
            Button(action: viewModel.saveTags) {
                Text("Apply")
                    .font(FontFamily.SFProText.medium.swiftUIFont(size: 16))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Asset.Colors.orangeBase.swiftUIColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Button(action: viewModel.removeAllTags)  {
                Text("Reset")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.clear)
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
        }
    }
}
