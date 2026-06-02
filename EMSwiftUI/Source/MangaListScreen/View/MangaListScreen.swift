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
                    .padding()
            case .error(let message):
                errorView(message)
            case .loaded:
                loadedContent
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var loadedContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                searchBar
                ForEach(viewModel.sections) { section in
                    MangaSectionView(section: section)
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, 8)
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: 4) {
            Image(.search)
                .foregroundStyle(.grayBase)
            Text("Search")
                .font(.SFPro.lightSmall)
                .foregroundStyle(.grayBase)
            Spacer()
        }
        .padding(.horizontal, 8)
        .frame(height: 36)
        .background(.whiteText)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.grayBase)
                .frame(height: 1)
        }
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Text(message)
                .font(.SFPro.bodyNormal)
                .multilineTextAlignment(.center)
            Button("Repeat") {
                viewModel.retry()
            }
            .font(.SFPro.bodyNormal)
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.orangeBase)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
    }
}
