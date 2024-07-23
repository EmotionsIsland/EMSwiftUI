//
//  DropDownView.swift
//  EMSwiftUI
//
//  Created by Vladislav Miroshnichenko on 14.07.2024.
//

import SwiftUI

struct DropDownView: View {
    
    @State private var selectionSection: Set<Int> = []
    @State private var rotation: Double = 0
    @Binding var selection: [String]
    
    var data: [FilterModel]
    
    let columns = [
        GridItem(.flexible(minimum: 100))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
            ForEach(data.indices, id: \.self) { index in
                let item = data[index]
                let isSection = isSectionSelected(section: index)
                
                Section {
                    
                    DropDownSubList(section: index,
                                    tags: item.tags,
                                    isHidden: isSection,
                                    selection: $selection)
                    
                } header: {
                    HStack(spacing: 8) {
                        Text(item.type.description)
                        Image(systemName: StringConstants.chevronImage)
                            .rotationEffect(.degrees(isSection ? 90 : 0))
                            
                    }
                    .animation(.easeIn(duration: 0.1), value: rotation)
                    .font(
                        FontFamily.SFProText.light.swiftUIFont(size: 20)
                    ).onTapGesture {
                        tapOnSection(at: index)
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    public init(data: [FilterModel], selection: Binding<[String]>) {
        self.data = data
        self._selection = selection
    }
    
}

//MARK: - Extension with private methods

private extension DropDownView {
    
    func tapOnSection(at index: Int) {
        let isSelected = isSectionSelected(section: index)
        
        if !isSelected {
            selectionSection.insert(index)
        } else {
            selectionSection.remove(index)
        }
    }
    
    func isSectionSelected(section: Int) -> Bool {
        selectionSection.contains(section)
    }
    
}

//MARK: - Extension with private subobjects

private extension DropDownView {
    
    enum StringConstants {
        static let chevronImage = "chevron.right"
    }
    
    struct DropDownSubList: View {

        @Binding var selection: [String]
        
        let section: Int
        let tags: [String]
        var isHidden: Bool
        
        let columns = [
            GridItem(.flexible(minimum: 20))
        ]
        
        var body: some View {
            VStack {
                VStack {
                    if isHidden {
                        TagsView(data: tags) { item in
                            let isSelected = selection.contains(item)
                            
                            TagsViewItem(title: item, isSelected: isSelected)
                                .onTapGesture {
                                    if !isSelected {
                                        selection.append(item)
                                    } else {
                                        guard let index = selection.firstIndex(of: item) else { return }
                                        selection.remove(at: index)
                                    }
                                }
                        }
                    }
                }
            }
            
        }
        
        public init(section: Int, tags: [String],  isHidden: Bool, selection: Binding<[String]>) {
            self.isHidden = isHidden
            self.section = section
            self.tags = tags
            self._selection = selection
        }
        
    }
    
}
