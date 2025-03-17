//
//  FilterViewModel.swift
//  EMSwiftUI
//
//  Created by Evgenii Mikhailov on 14.03.2025.
//

import Foundation
import Combine

final class FilterViewModel: ObservableObject {
    private let service = FilterViewService(network: Network())
    @Published private(set) var selectedTags: [Tag] = []
    @Published private(set) var tags: [Tag] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        getData()
    }
    func toggleSelection(for tag: Tag) {
        guard let index = tags.firstIndex(where: { $0.id == tag.id }) else { return }
        tags[index].isSelected.toggle()
        
        if selectedTags.contains(where: {$0.id == tag.id}) {
            selectedTags.removeAll(where: {$0.id == tag.id})
        } else {
            selectedTags.append(tags[index])
        }
    }
    
    func resetTags() {
        selectedTags.removeAll()
        tags.indices.forEach { tags[$0].isSelected = false }
    }
    
    private func getData() {
        service.getManga()
            .receive(on: DispatchQueue.main)
            .sink { comp in
                switch comp {
                case .failure(let error):
                    print ("Error: \(error)")
                default:
                    break
                }
            } receiveValue: { [weak self] mangas in
                guard let self else { return }
                self.tags = mangas.data.first?.attributes.tags ?? []
            }
            .store(in: &cancellables)
    }
}
