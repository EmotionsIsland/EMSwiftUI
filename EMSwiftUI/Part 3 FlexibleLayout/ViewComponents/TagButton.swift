//
//  TagButton.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 11.03.2025.
//

import SwiftUI

enum ButtonMode {
    case unselected, selected
}

struct TagButton: View {
    @ObservedObject var tagViewModel: TagViewModel
    let title: String
    let tag: String
    let buttonMode: ButtonMode
    
    var body: some View {
        let _ = print(title)
        Button {
            tagViewModel.manageButtonState(
                by: buttonMode,
                for: title, tag
            )
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "plus")
                Text(tag)
                    .lineLimit(1)
            }
            .padding(8)
        }
        .fixedSize()
        .modifier(ContentModifier(buttonMode: buttonMode))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct ContentModifier: ViewModifier {
    let buttonMode: ButtonMode
    
    func body(content: Content) -> some View {
        switch buttonMode {
        case .unselected:
            content
                .foregroundStyle(.blackBase)
                .background(Color.grayBase)
        case .selected:
            content
                .foregroundStyle(.white)
                .background(Color.orangeBase)
        }
    }
}

#Preview {
    TagButton(
        tagViewModel: TagViewModel(),
        title: TagStruct.defaultTag.title,
        tag: TagStruct.defaultTag.tag,
        buttonMode: .unselected
    )
}
