//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(Font.SFPro.headline3)
            Spacer()
            Button {
              print("more")
            } label: {
                HStack {
                    Text("more")
                        .font(Font.SFPro.bodyNormal)
                    Image("moreIcon")
                        .resizable()
                        .frame(width: 12, height: 12)
                }
                .foregroundStyle(Color.blackBase)
            }
        }
    }
}

#Preview {
    MangaSectionView(title: "Popular")
}
