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
                .foregroundStyle(Color.init(cgColor: #colorLiteral(red: 0.21960783, green: 0.21960783, blue: 0.21960783, alpha: 1)))
            }
        }
    }
}

#Preview {
    MangaSectionView(title: "Popular")
}
