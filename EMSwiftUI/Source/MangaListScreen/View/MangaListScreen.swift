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
                Image("search")
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
                    switch viewModel.viewState {
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
