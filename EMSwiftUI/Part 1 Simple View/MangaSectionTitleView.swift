//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            sectionTitle
            Spacer()
            sectionButton
        }
    }
}

private extension MangaSectionTitleView {
    
    var sectionTitle: some View {
        Text(title)
            .foregroundStyle(.blackBase)
            .font(FontFamily.SFProText.bold.swiftUIFont(size: 20))
    }
    
    var sectionButton: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 8) {
                Text("more")
                    .font(FontFamily.SFPro.regular.swiftUIFont(size: 16))
                Image(.moreIcon)
            }
            .foregroundStyle(.blackBase)
        }
    }
    
}
