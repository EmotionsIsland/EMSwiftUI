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
                .font(Font.SFPro.headline3)
            
            Spacer()
            
            HStack(spacing: 16) {
                Text("more")
                Image(systemName: "chevron.right")
            }
            .font(Font.SFPro.bodyNormal)
        }
    }
}
