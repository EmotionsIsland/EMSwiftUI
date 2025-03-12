//
//  SelectionView.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 10.03.2025.
//

import SwiftUI

struct SelectionView: View {
    @ObservedObject var tagModel: TagModel
    let availableWidthSpace: CGFloat
    let buttonsMode: ButtonMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Selection")
                .font(FontFamily.SFProText.bold.swiftUIFont(fixedSize: 20))
                .foregroundStyle(.blackBase)
            
            GridView(
                tagModel: tagModel,
                tags: tagModel.selectedTags,
                availableWidthSpace: availableWidthSpace,
                buttonsMode: buttonsMode
            )
            
            VStack(spacing: 0) {
                Button { print("Apply filters") } label: {
                    Text("Apply")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(Color.orangeBase)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Button {
                    tagModel.removeAll()
                } label: {
                    Text("Reset")
                        .foregroundStyle(.blackBase)
                }
                .frame(maxWidth: .infinity, minHeight: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Divider()
            }
            .padding(.bottom, 16)
        }
    }
}

#Preview {
    SelectionView(
        tagModel: TagModel(),
        availableWidthSpace: 300,
        buttonsMode: .orange
    )
}
