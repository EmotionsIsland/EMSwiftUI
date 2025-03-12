//
//  TagButton.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 11.03.2025.
//

import SwiftUI

enum ButtonMode {
    case white, orange
}

struct TagButton: View {
    @ObservedObject var tagModel: TagModel
    let tag: String
    let buttonMode: ButtonMode
    
    var body: some View {
        Button {
        switch buttonMode {
        case .white:
            tagModel.addTag(tag)
        case .orange:
            tagModel.removeTag(tag)
        } } label: {
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
        case .white:
            content
                .foregroundStyle(.blackBase)
                .background(Color.grayBase)
        case .orange:
            content
                .foregroundStyle(.white)
                .background(Color.orangeBase)
        }
    }
}

#Preview {
    TagButton(
        tagModel: TagModel(),
        tag: "Default topic",
        buttonMode: .white
    )
}
