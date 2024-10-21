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
                    
                    Divider()
                    
                    DisclosureView
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


#Preview {
    FilterView()
}
