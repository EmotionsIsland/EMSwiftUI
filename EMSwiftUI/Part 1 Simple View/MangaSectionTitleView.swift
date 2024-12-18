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
            
            Spacer()
            
            Button {
               
            } label: {
                HStack {
                    Text("more")
                        .font(.custom(FontFamily.SFProText.regular, size: 16))
                    Image(.moreIcon)
                }
            }
        }
        .foregroundStyle(.blackBase)
        .padding(.vertical, 16)
    }
}
