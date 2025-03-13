//
//  SelectionView.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 10.03.2025.
//

import SwiftUI

struct SelectionView: View {
    @ObservedObject var tagViewModel: TagViewModel
    let availableWidthSpace: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Selection")
                .font(FontFamily.SFProText.bold.swiftUIFont(fixedSize: 20))
                .foregroundStyle(.blackBase)
            
            GridView(
                tagViewModel: tagViewModel,
                gridViewMode: .selection,
                title: "Selection",
                availableWidthSpace: availableWidthSpace
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
                    tagViewModel.removeAll()
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
        tagViewModel: TagViewModel(),
        availableWidthSpace: 300
    )
}
