//
//  MangaGridViewModel.swift
//  EMSwiftUI
//
//  Created by Vladislav Miroshnichenko on 23.07.2024.
//

import Foundation

final class MangaGridViewModel: ObservableObject {
    
    private(set) var data: MangaData
    
    public init(data: MangaData) {
        self.data = data
    }
    
}

//MARK: - Extension with public methods

extension MangaGridViewModel {
    
    public func getTags() -> String {
        return data.attributes.tags.compactMap { $0.attributes.name.en }
            .joined(separator: ",")
    }
    
}
