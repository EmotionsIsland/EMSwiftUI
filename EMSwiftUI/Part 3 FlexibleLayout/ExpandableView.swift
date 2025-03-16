//
//  FoldableSectionView.swift
//  EMSwiftUI
//
//  Created by Evgenii Mikhailov on 14.03.2025.
//

import SwiftUI

struct ExpandableView: View {
    let tags: [Tag]
    let title: String
    @State private var isFolded = true
    @ObservedObject var viewModel: FilterViewModel
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                HStack {
                    Text(title)
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isFolded ? 0 : 180))
                        .animation(.easeInOut(duration: 0.2), value: isFolded)
                    Spacer()
                }
                .frame(height: 24)
                .onTapGesture {
                    withAnimation(Animation.easeInOut(duration: 0.2)) {
                        isFolded.toggle()
                    }
                }
                
                if !isFolded {
                    Group {
                        WrappingStack(items: tags, spacing: 8, singleItemHeight: 36, content: { tag in
                                TagView(tag: tag, viewModel: viewModel) 
                            })
                    }
                    .transition(.opacity)
                }
            }
        }
    }
}
