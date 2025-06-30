//
//  FilterExpandableSection.swift
//  EMSwiftUI
//
//  Created by Ruslan on 25.06.2025.
//

import SwiftUI

struct FilterExpandableSection: View {
    let name: String
    
    var action: (String, Bool) -> Void = { _,_ in }
    
    var tags: [MangaTagRepresentable]
    
    @State var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .font(Font.SFPro.headline2)
                    .foregroundStyle(.blackBase)
                
                Image(uiImage: .moreIcon)
                    .rotationEffect(.init(degrees: isExpanded ? 90 : 0))
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                TagListView(tags: tags, spacing: 5, action: action)
            }
        }
        .frame(minHeight: 50)
    }
}
