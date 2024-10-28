//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = FilterViewModel()
    
    @State private var availableWidth: CGFloat = 0
    
    var body: some View {
        
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    selectionMainView
                    Divider()
                    disclosureView
                }
            }
            .padding()
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundStyle(.blackBase)
                    }
                }
            }
        }
    }
}

private extension FilterView {
    
    var selectionMainView: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Selection")
                    .font(.custom(FontFamily.SFProText.semibold, size: 20))
                    .frame(alignment: .leading)
                
                Spacer()
            }
            
            FlexibleView(
                data: viewModel.selection,
                spacing: 8
            ) { item in
                HStack(spacing: 4) {
                    Image(systemName: "plus")
                        .padding(8)
                    
                    Text(verbatim: item)
                        .padding(.trailing, 8)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.orangeBase)
                )
                .foregroundStyle(.white)
            }
            
            VStack(spacing: 8) {
                Button {
                    // TODO: add apply func
                } label: {
                    Text("Apply")
                        .font(.custom(FontFamily.SFPro.medium, size: 16))
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 44)
                .background(.orangeBase)
                .foregroundStyle(.white)
                .cornerRadius(8)
                
                Button("Reset") {
                    viewModel.resetSelection()
                }
                .font(.custom(FontFamily.SFPro.medium, size: 16))
                .buttonStyle(.plain)
                .foregroundStyle(.blackBase)
            }
        }
    }
    
    var disclosureView: some View {
        HStack {
            VStack(spacing: 24) {
                ForEach(viewModel.filetrs) { item in
                    DisclosureGroup(item.name.capitalized) {
                        FlexibleView(data: item.tags, spacing: 8) { item in
                            Button {
                                if !viewModel.isTagInSelection(item: item) {
                                    viewModel.addToSelection(item: item)
                                }
                            } label: {
                                HStack(spacing: 4) {
                                    if viewModel.isTagInSelection(item: item) {
                                        Image(systemName: "plus")
                                            .foregroundStyle(.white)
                                            .padding(.leading, 8)
                                    }
                                    Text(item)
                                        .padding(8)
                                        .padding(.leading, 0)
                                        .foregroundStyle(viewModel.isTagInSelection(item: item) ? .white : .blackBase)
                                }
                                .background(viewModel.isTagInSelection(item: item) ? .orangeBase : .grayBase)
                                .cornerRadius(8)
                            }
                        }
                    }
                }
            }
            .foregroundStyle(.blackBase)
            .tint(.blackBase)
        }
    }
}

#Preview {
    FilterView()
}
