//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @StateObject private var viewModel = FilterViewModel()
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100, maximum: 300), spacing: 1)
    ]
    @State var title: String
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Selection")
                        .font(.custom(FontFamily.SFPro.bold, size: 20))
                    if !viewModel.selectedTags.isEmpty {
                        WrappingStack(items: viewModel.selectedTags, spacing: 8, singleItemHeight: 20) { tag in
                            TagView(tag: tag, viewModel: viewModel)
                        }
                    }
                    
                    Button {} label: {
                        Text("Apply")
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(.orangeBase)
                            .cornerRadius(10)
                            .foregroundStyle(.white)
                    }
                    
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
                    Divider()
                }
                .padding(.horizontal)
                VStack {
                    ForEach(viewModel.tags, id: \.id) { collection in
                        ExpandableView(tags: viewModel.tags, title: collection.attributes?.name.en ?? "", viewModel: viewModel)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .onAppear {
                viewModel.getData()
            }
        }
    }
}

#Preview {
    FilterView(title: "Filters")
}
