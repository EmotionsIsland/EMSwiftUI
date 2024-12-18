//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MangaListViewModel
    @State var inputText: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                SearchBarView(inputText: $inputText)
                    .padding(.horizontal, 16)
                
                Divider()
                    .padding(.top, 1)
                    .background(Asset.Colors.grayBase.swiftUIColor)
                
                switch viewModel.state {
                case .successfull:
                    MangaSectionView(mangaSection: "Popular",
                                     mangas: viewModel.mangaList,
                                     moreButton: {},
                                     coverURL: { manga in viewModel.getCoverURL(manga: manga, sizeFormat: .size256) })
                    
                case .failed(error: let error):
                    errorView(error: error)
                    
                case .notAvailable:
                    loadView
                }
                
            }
        }
        .onAppear {
            viewModel.getData()
        }
    }
}

//MARK: - UI

private extension MainView {
    func errorView(error: Error) -> some View {
        Text(error.localizedDescription)
            .font(FontFamily.SFProText.regular.swiftUIFont(size: 20))
            .foregroundStyle(Asset.Colors.grayBase.swiftUIColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    var loadView: some View {
        VStack {
            ProgressView()
            Text("Загрузка")
                .font(FontFamily.SFProText.regular.swiftUIFont(size: 16))
                .foregroundStyle(Asset.Colors.grayBase.swiftUIColor)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

//#Preview {
//    MainView()
//}
