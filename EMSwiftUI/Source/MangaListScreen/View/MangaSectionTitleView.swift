//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(Font.SFPro.headline3)
            Spacer()
            Button {
                print("More Tapped")
            } label: {
                Group {
                    Text("more")
                        .font(Font.SFPro.bodyNormal)
                    Image(.moreIcon)
                }
                .foregroundStyle(.blackBase)
            }
        }
    }
}
