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
        Group {
            switch viewModel.viewState {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.vertical, 8)

            case .error(let message):
                VStack(spacing: 12) {
                    Text(message)
                        .font(.SFPro.bodyNormal)
                        .foregroundStyle(.blackBase)
                        .multilineTextAlignment(.center)

                    Button(
                        action: {
                            viewModel.retry()
                        },
                        label: {
                            Text("Повторить")
                                .font(.SFPro.bodyNormal)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color.orangeBase)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    )
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .content:
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        searchView

                        ForEach(viewModel.sections) { section in
                            MangaSectionView(section: section)
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 8)
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }

    private var searchView: some View {
        HStack(spacing: 4) {
            Image(.search)
                .foregroundStyle(.grayBase)
            Text("Search")
                .font(.SFPro.lightSmall)
                .foregroundStyle(.grayBase)
        }
        .padding(.horizontal, 4)
        .frame(height: 36)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.whiteText)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.grayBase)
                .frame(height: 1)
        }
    }
}
