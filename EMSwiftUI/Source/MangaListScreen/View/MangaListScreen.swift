//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var searchText: String = ""
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
                    if viewModel.isLoading {
                        ProgressView("Загрузка...")
                            .padding()
                    } else if let error = viewModel.error {
                        VStack {
                            Text("Ошибка: \(error.localizedDescription)")
                                .foregroundColor(.red)
                            Button("Повторить") {
                                Task { await viewModel.fetchData() }
                            }
                        }.padding()
                    } else if viewModel.sections.isEmpty {
                        Text("Нет данных для отображения")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(viewModel.sections, id: \.id) { section in
                            MangaSectionView(section: section)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
                .animation(.easeInOut, value: viewModel.isLoading)
            }
        }.task {
            await viewModel.fetchData()
        }
    }
}
