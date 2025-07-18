//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Factory

struct FilterScreenView<ViewModel: FilterScreenViewModel>: View {
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Filters")
                .font(.custom("SFProText-Bold", size: 24))
                .foregroundStyle(
                    Color.blackBase
                )
                
            Divider()
                .foregroundStyle(
                    Color(red: 196/255, green: 196/255, blue: 196/255)
                )
                
            HStack {
                Text("Selection")
                    .font(.custom("SFProText-Bold", size: 20))
                    .foregroundStyle(
                        Color.blackBase
                    )
                    
                Spacer()
            }
                
            // TODO: Implement a flexible layout
                
            VStack(spacing: 8) {
                Button {
                    // ...
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 358, height: 44)
                        .foregroundStyle(
                            Color.orangeBase
                        )
                        .overlay {
                            Text("Apply")
                                .font(.custom("SFProDisplay-Medium", size: 16))
                                .foregroundStyle(Color.whiteText)
                        }
                }
                    
                Button {
                    // ...
                } label: {
                    Text("Reset")
                        .font(.custom("SFProDisplay-Medium", size: 16))
                        .foregroundStyle(
                            Color.blackBase
                        )
                }
            }
                
            Divider()
                .padding(.horizontal)
            
            ScrollView {
                ForEach(viewModel.tagGroups) { group in
                    Section {
                        if group.isUnfolded {
                            
                        }
                    } header: {
                        
                    }
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .task {
            await viewModel.onAppear()
        }
    }
}
