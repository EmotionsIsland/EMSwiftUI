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
        HStack(spacing: 12) {
            Text(title)
                .font(.SFPro.headline3)
                .foregroundColor(.blackBase)
            
            Spacer()

            Text("more")
                .font(.SFPro.mediumNormal)
                .foregroundColor(.blackBase)
            
            Image(.moreIcon)
                .renderingMode(.template)
                .foregroundStyle(.blackBase)
        }
    }
}
