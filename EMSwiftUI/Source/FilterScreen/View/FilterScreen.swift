//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen: View {
    let apply: () -> Void
    
    @StateObject private var viewModel = FilterTagViewModel()
    @State private var expandedGroups: Set<String> = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Selection")
                    .font(.SFPro.headline3)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                FlexibleLayout(data: Array(viewModel.selectedTags), spacing: 8, alignment: .leading) { tag in
                    FilterTagView(tag: tag, isSelected: true) {
                        viewModel.toggleTag(tag)
                    }
                }
                .padding(.horizontal)
                
                if !viewModel.selectedTags.isEmpty {
                    VStack(spacing: 16) {
                        Button {
                            apply()
                        } label: {
                            Text("Apply")
                                .font(.SFPro.bodyNormal)
                                .foregroundColor(.whiteText)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color("orangeBase"))
                                .cornerRadius(8)
                        }
                        
                        Button {
                            viewModel.reset()
                        } label: {
                            Text("Reset")
                                .font(.SFPro.bodyNormal)
                                .foregroundColor(.blackBase)
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                }
                
                ForEach(viewModel.groups) { group in
                    FilterTagGroupView(
                        group: group,
                        selectedTags: viewModel.selectedTags,
                        onTagTap: { viewModel.toggleTag($0) }
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
        .task {
            await viewModel.fetchTags()
        }
    }
}
