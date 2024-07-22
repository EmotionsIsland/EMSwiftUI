//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    
    //MARK: - Private properties
    
    @StateObject private var viewModel: MangaListViewModel = .init()
    @State private var animmation = false
    
    //MARK: - UI
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                ScrollViewReader { scrollView in
                    ScrollView(.vertical, showsIndicators: false) {
                        MangaSectionView()
                            .environmentObject(viewModel)
                    }
                    .refreshable {
                        viewModel.fetchData()
                    }
                    .alert(StringConstants.networkErrorTitle, isPresented: $viewModel.hasError,
                           actions: {
                        Button(StringConstants.okButton) {
                            viewModel.hasError = false
                        }
                    }) {
                        Text(viewModel.errorMessage)
                    }
                }
                
            }
            .foregroundStyle(Colors.background)
            .onAppear {
                viewModel.fetchData()
            }
            .searchable(text: $viewModel.filterPredicate,
                        prompt: Text(StringConstants.searchBarPlaceholder)
            )
        }
    }
    
}

//MARK: - Extension with private subobjects

private extension MainView {
    
    enum Colors {
        static let background = Color.white
    }
    
    enum StringConstants {
        static let searchBarPlaceholder = "Search"
        static let networkErrorTitle = "Nerwork Error"
        static let okButton = "OK"
        
    }
    
    enum Fonts {
        static let searchBarPlaceholder = FontFamily.SFPro.light.swiftUIFont(size: 14)
    }
    
}

#Preview {
    MainView()
}
