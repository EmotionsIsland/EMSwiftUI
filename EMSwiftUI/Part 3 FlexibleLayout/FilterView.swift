//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct FilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = FilterViewModel()
    
    var body: some View {
        Divider()
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Selection")
                    .font(FontFamily.SFProText.bold.swiftUIFont(fixedSize: 20))
                
                TagLayout(alignment: .center, spacing: 8) {
                    ForEach(viewModel.selectedTags.indices, id: \.self) { index in
                        TagView(tag: $viewModel.selectedTags[index]) { selectTag in
                            if !selectTag.select {
                                viewModel.removeTag(selectTag, needDeletePlus: true)
                            }
                        }
                    }
                }
                
                
                VStack(spacing: 0) {
                    Button(action: viewModel.saveTags) {
                        Text("Apply")
                            .font(FontFamily.SFProText.medium.swiftUIFont(size: 16))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Asset.Colors.orangeBase.swiftUIColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Button(action: {
                        withAnimation {
                            viewModel.removeAllTags()
                        }
                    })  {
                        Text("Reset")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.clear)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                }
                Divider()
                    .padding(.vertical)
                ForEach(viewModel.sections.indices, id: \.self) { index in
                    CollapsibleSection(
                        title: viewModel.sections[index].0,
                        tags: $viewModel.sections[index].1,
                        onSelect: { tag in
                            if tag.select {
                                viewModel.addTag(tag, needDeletePlus: false)
                            } else {
                                viewModel.removeTag(tag, needDeletePlus: false)
                            }
                            
                        }
                    )
                    .padding(.top, index > 0 ? 13 : 0)
                    .padding(.bottom, 13)
                }
            }
            .padding()
        } .navigationTitle("Filters")
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
