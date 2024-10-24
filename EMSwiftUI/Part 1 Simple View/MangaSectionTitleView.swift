//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

// MARK: - MangaSectionTitleView
struct MangaSectionTitleView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom(FontFamily.SFPro.bold, size: 20))
                .foregroundStyle(.blackBase)
            Spacer()
            
            Button {
                print("Button pressed")
            } label: {
                Text("more")
                Image(.moreIcon)
            }
            .font(.custom(FontFamily.SFPro.regular, size: 16))
            .foregroundStyle(.blackBase)
        }
        .padding(16)
    }
}

#Preview {
    MangaSectionTitleView(title: "Test")
}
