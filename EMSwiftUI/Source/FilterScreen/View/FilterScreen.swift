//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Factory

struct FilterScreen<VM: FilterScreenViewMode>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack {
               Text("Screen")
            }
            .padding(.vertical)
            .onAppear {
                Task {
                    do {
                        try await viewModel.getData()
                    } catch {
                        print("Ошибка при загрузке: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    FilterScreen(viewModel: FilterScreenViewModelImpl(service: MangaListServiceImpl(netify: Container.shared.netify())))
}
