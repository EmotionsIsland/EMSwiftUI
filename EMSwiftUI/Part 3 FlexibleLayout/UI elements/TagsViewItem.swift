//
//  TagsViewItem.swift
//  EMSwiftUI
//
//  Created by Vladislav Miroshnichenko on 22.07.2024.
//

import SwiftUI

struct TagsViewItem: View, Identifiable, Hashable {
    
    //MARK: - Private properties
    
    public let id = UUID()
    private let title: String
    private let isSelected: Bool
    
    //MARK: - UI
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                Image(systemName: isSelected ? StringConstants.plusImage : StringConstants.empty)
                
                Text(title)
            }
            .foregroundStyle(Color.whiteText)
            .padding(8)
            .fixedSize()
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundStyle(isSelected ? Color.orangeBase : Color.grayBase)
            )
            
        }
    }
    
    //MARK: - Initialaizers
    
    public init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}

//MARK: - Extension with private subobjects

private extension TagsViewItem {
    
    enum StringConstants {
        static let plusImage = "plus"
        static let empty = ""
    }
    
}
