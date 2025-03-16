//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Evgenii Mikhailov on 14.03.2025.
//

import Foundation
import Combine
import SwiftUI

final class FilterViewModel: ObservableObject {
    private let network = Network() // For Mock Tags
    @Published private(set) var selectedTags: [Tag] = []
    @Published private(set) var tags: [Tag] = []
    @Published private var cancellables: Set<AnyCancellable> = []
    
    func toggleSelection(for tag: Tag) {
        withAnimation {
            if let index = tags.firstIndex(where: { $0.id == tag.id }) {
                if tags[index].isSelected == true {
                    tags[index].isSelected = false
                } else {
                    tags[index].isSelected = true
                }
                
                
                if selectedTags.contains(where: {$0.id == tag.id}) {
                    selectedTags.removeAll(where: {$0.id == tag.id})
                } else {
                    selectedTags.append(tags[index])
                }
            }
        }
    }
    
    func resetTags() {
        withAnimation {
            selectedTags.removeAll()
            tags.indices.forEach { tags[$0].isSelected = false }
            
            for index in tags.indices {
                tags[index].isSelected = false
            }
        }
    }
    
    private func getManga() -> AnyPublisher<MangaListModel, Error> {
        let endpoint = Endpoint.mangaList
        return network.getData(with: endpoint.url, MangaListModel.self)
    }
    
    func getData() {
        getManga()
            .receive(on: DispatchQueue.main)
            .sink { comp in
                switch comp {
                case .failure(let error):
                    print ("Error: \(error)")
                default:
                    break
                }
            } receiveValue: { mangas in
                self.tags = mangas.data.first?.attributes.tags ?? []
            }
            .store(in: &cancellables)
    }
}
