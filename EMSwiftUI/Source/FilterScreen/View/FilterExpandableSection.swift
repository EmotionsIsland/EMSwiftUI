//
//  FilterExpandableSection.swift
//  EMSwiftUI
//
//  Created by Ruslan on 25.06.2025.
//

import SwiftUI

struct FilterExpandableSection: View {
    let name: String
    
    let action: (String, Bool) -> Void
    
    let tags: [MangaTagRepresentable]
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .font(Font.SFPro.headline2)
                    .foregroundStyle(.blackBase)
                
                Image(uiImage: .moreIcon)
                    .rotationEffect(.init(degrees: isExpanded ? 90 : 0))
                
                Spacer()
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            TagListView(tags: tags, spacing: 5, action: action)
            .allowsHitTesting(isExpanded)
            .frame(height: isExpanded ? nil : 0)
            .clipped()
        }
        .frame(minHeight: 50)
    }
}
