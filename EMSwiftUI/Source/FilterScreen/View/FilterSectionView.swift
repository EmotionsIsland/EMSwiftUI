//
//  FilterSectionView.swift
//  EMSwiftUI
//
//  Created by Pavel Plyago on 24.07.2025.
//

import SwiftUI

struct FilterSectionView<VM: TagViewModel>: View {
    let section: TagSection
    @EnvironmentObject var viewModel: VM 
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(
                action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
            },
                label: {
                    HStack(spacing: 8) {
                        Text(section.title.capitalized)
                            .font(Font.SFPro.regularLarge)
                            .foregroundColor(.blackBase)
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                            .foregroundColor(.blackBase)
                            .animation(.easeInOut, value: isExpanded)
                    }
                }
            )

            if isExpanded {
                FlexibleTagGrid(tags: section.items) { tag in
                    viewModel.toggleTag(tag)
                }
                .transition(.opacity)
            }
        }
    }
}
