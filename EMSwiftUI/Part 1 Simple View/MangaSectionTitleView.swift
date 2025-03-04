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
                .font(.custom(FontFamily.SFProText.bold, size: 20))
                .foregroundColor(.black)
            Spacer()
            Button(action: {}) {
                HStack {
                    Text("more")
                        .font(.custom(FontFamily.SFProText.light, size: 16))
                        .foregroundColor(.black)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    MangaSectionTitleView(title: "Popular")
}
