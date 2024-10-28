//
//  SectionsView.swift
//  EMSwiftUI
//
//  Created by Aleksandr Moskovtsev on 27.10.2024.
//

import SwiftUI

// MARK: - Section View
struct SectionView: View {
    
    var section: SectionModel
    
    @ObservedObject var viewModel: FilterViewModel

    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            SectionButton(section: section, isExpanded: $isExpanded)
            
            if isExpanded {
                HStack {
                    FlexibleLayoutView(data: section.tags) { tag in
                        TagButton(tag: tag, viewModel: viewModel)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)

            }
        }
    }
}

// MARK: - Preview
#Preview {
    SectionView(
        section: SectionModel(section: .genre),
        viewModel: FilterViewModel(activeFilters: [])
    )
}

// MARK: - Section Button
struct SectionButton: View {
    
    var section: SectionModel
    
    @Binding var isExpanded: Bool
    
    var body: some View {
        Button {
            isExpanded.toggle()
        } label : {
            HStack(spacing: 8) {
                Text(section.title)
                    .font(.custom(FontFamily.SFPro.regular, size: 20))
                
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                
                Spacer()
            }
        }
        .padding()
        .foregroundStyle(.blackBase)
    }
}


