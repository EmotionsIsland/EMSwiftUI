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
                .foregroundStyle(Color.blackBase)
                .font(Font.SFPro.headline2)
                
            Spacer()
            
            Button {
            } label: {
                HStack {
                    Text("more")
                    
                    Spacer()
                        .frame(width: 8)
                    
                    Image(uiImage: .moreIcon)
                }
            }
            .foregroundStyle(Color.blackBase)
        }
    }
}
