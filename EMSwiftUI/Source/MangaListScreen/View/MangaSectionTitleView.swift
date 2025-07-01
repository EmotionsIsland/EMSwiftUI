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
        VStack {
            HStack {
                Text(title)
                    .font(Font.SFPro.headline3)
                Spacer()
                Button {
                   action()
                } label: {
                    HStack(spacing: 20) {
                        Text("more")
                            .font(.system(size: 16, weight: .medium))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .medium))
                    }
                }
            }
        }
        .foregroundColor(.blackBase)
    }
}
