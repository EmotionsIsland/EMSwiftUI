//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

enum MangaListViewState {
    case loading
    case error(Error)
    case empty
    case success([MangaSection])
}

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var searchText: String = ""
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var viewState: MangaListViewState {
        if viewModel.isLoading {
            return .loading
        } else if let error = viewModel.error {
            return .error(error)
        } else if viewModel.sections.isEmpty {
            return .empty
        } else {
            return .success(viewModel.sections)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.vertical, 8)
            }
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding()
            
            Divider()
                .padding(.horizontal)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    switch viewState {
                    case .loading:
                        ProgressView("Загрузка...")
                            .padding()
                    case .error(let error):
                        VStack {
                            Text("Ошибка: \(error.localizedDescription)")
                                .foregroundColor(.red)
                            Button("Повторить") {
                                Task { await viewModel.fetchData() }
                            }
                        }.padding()
                    case .empty:
                        Text("Нет данных для отображения")
                            .foregroundColor(.gray)
                            .padding()
                    case .success(let array):
                        ForEach(array, id: \.id) { section in
                            MangaSectionView(section: section)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
        }.task {
            await viewModel.fetchData()
        }
    }
}
