//
//  MangaListScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI
import Factory

struct MangaListScreen<VM: MangaListViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        MangaSectionView(viewModel: viewModel)
    }
}

#Preview {
    MangaListScreen(viewModel: MangaListViewModelImpl(service: MangaListServiceImpl(netify: Container.shared.netify())))
}
