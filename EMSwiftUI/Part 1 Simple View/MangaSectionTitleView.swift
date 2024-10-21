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
                .font(.custom(FontFamily.SFPro.bold, size: 20))
            
            Spacer()
            
            Button(action: {
                // TODO: add action
            }) {
                Text("more")
                    .font(.custom(FontFamily.SFPro.regular, size: 16))
                    .minimumScaleFactor(0.5)
                    .frame(width: 45)
                
                Image(.moreIcon)
            }
            .buttonStyle(.plain)
            .frame(width: 67, height: 24)
        }
    }
}
