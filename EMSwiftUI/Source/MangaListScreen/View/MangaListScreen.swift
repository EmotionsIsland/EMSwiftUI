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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 40) {
                MangaSectionView(title: "Категория 1") {
                    ForEach(0..<3) { _ in
                        Color.gray.frame(height: 150)
                    }
                }
                
                MangaSectionView(title: "Категория 2") {
                    ForEach(0..<3) { _ in
                        Color.gray.frame(height: 150)
                    }
                }
                
                MangaSectionView(title: "Категория 3") {
                    ForEach(0..<3) { _ in
                        Color.gray.frame(height: 150)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
