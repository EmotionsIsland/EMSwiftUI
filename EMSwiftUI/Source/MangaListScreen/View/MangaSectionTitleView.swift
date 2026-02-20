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
        HStack(alignment: .center) {
            Text(title)
                .font(.SFPro.headline3)
            
            Spacer()
            
            Button(action: {}, label: {
                HStack(alignment: .top, spacing: 8) {
                    Text("more")
                        .font(.SFPro.bodyNormal)
                    Image(.moreIcon)
                        .resizedToFill(width: 24, height: 24)
                }
            })
        }
        .foregroundColor(.blackBase)
    }
}
