//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI
@available(iOS 16.0, *)
struct MainView: View {
    @StateObject private var viewModel = MangaListViewModel()
    @State private var isFilterViewPresented = false
    @State private var selectedTab: Int = 0
    @State private var searchText = "" // заранее
    
    
   
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Asset.Colors.grayBase.swiftUIColor)
                        .padding(.leading, 7)
                    TextField("Search", text: $searchText)
                        .padding(.leading, 4)
                        .padding(.horizontal, 8)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .frame(height: 36)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                Divider()
                    .padding(.top, 1)
                    .background(Asset.Colors.grayBase.swiftUIColor)
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 16) {
                            // MARK: -- Здесь можно будет генерировать определенное количество секкций
                            MangaSectionView(
                                mangaSection: "Popular",
                                mangaList: viewModel.mangaList,
                                onMoreTapped: {
                                    isFilterViewPresented = true
                                }
                            )
                        }
                        .padding(.top)
                    }
                }
                
                Divider()
                    .padding(.top, 1)
                    .background(Asset.Colors.grayBase.swiftUIColor)
                    .frame(maxWidth: .infinity)
                
                TabBar(selectedTab: $selectedTab)
                    .padding(.horizontal, 24)
            }
            .background(
                NavigationLink(
                    destination: FilterView(),
                    isActive: $isFilterViewPresented,
                    label: { EmptyView() }
                )
            )
            .onAppear {
                viewModel.getData()
            }
        }
    }
}

//#Preview {
//    MainView()
//}
