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
                
                // Tag groups
                ForEach(viewModel.groups) { group in
                    VStack(alignment: .leading, spacing: 8) {
                        Button {
                            if expandedGroups.contains(group.id) {
                                expandedGroups.remove(group.id)
                            } else {
                                expandedGroups.insert(group.id)
                            }
                        } label: {
                            HStack {
                                Text(group.name)
                                Image(systemName: expandedGroups.contains(group.id) ? "chevron.up" : "chevron.down")
                            }
                            .font(.SFPro.regularLarge)
                            .foregroundColor(.blackBase)
                        }
                        if expandedGroups.contains(group.id) {
                            FlexibleLayout(data: group.tags, spacing: 8, alignment: .leading) { tag in
                                FilterTagView(tag: tag, isSelected: viewModel.selectedTags.contains(tag)) {
                                    viewModel.toggleTag(tag)
                                }
                            }
                        }
                    }
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

#if DEBUG
struct FilterScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilterScreen() {}
    }
}
#endif
