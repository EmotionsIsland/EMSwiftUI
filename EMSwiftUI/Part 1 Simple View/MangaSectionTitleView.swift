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
        HStack(alignment: .center) {
            Text(title)
                .font(.custom(FontFamily.SFPro.bold, size: 20))
                .foregroundStyle(.blackBase)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 8) {
                Text("more")
                    .font(.custom(FontFamily.SFPro.regular, size: 16))
                    .foregroundStyle(.blackBase)
                
                Image("moreIcon")
                    .foregroundStyle(.blackBase)
            }
        }
    }
}
