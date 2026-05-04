//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM

    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            }

            if let message = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Text(message)
                        .font(.SFPro.bodyNormal)
                        .foregroundStyle(.blackBase)
                        .multilineTextAlignment(.center)

                    Button(action: {
                        viewModel.onAppear()
                    }) {
                        Text("Repeat")
                            .font(.SFPro.bodyNormal)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.orangeBase)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    searchView

                    ForEach(viewModel.sections) { section in
                        MangaSectionView(section: section)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
        }
        .task {
            viewModel.onAppear()
        }
    }

    private var searchView: some View {
        HStack(spacing: 8) {
            Image(.search)
            Text("Search")
                .font(.SFPro.lightSmall)
                .foregroundStyle(.grayBase)
        }
        .padding(.horizontal, 12)
        .frame(height: 36)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.grayBase.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
