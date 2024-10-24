//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom(FontFamily.SFPro.bold, size: 20))
                .padding(.leading, 8)
            
            Spacer()
            
            moreButtonView
        }
        .padding(8)
    }
}

private extension MangaSectionTitleView {
    var moreButtonView: some View {
        Button(action: {}, label: {
            Text("more")
                .font(.custom(FontFamily.SFPro.regular, size: 16))
                .foregroundStyle(.blackBase)
            
            Image(.moreIcon)
                .foregroundColor(.blackBase)
        })
    }
}
