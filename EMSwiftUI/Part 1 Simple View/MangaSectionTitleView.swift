//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    var body: some View {
        HStack {
            Text("Popular")
                .font(.custom(FontFamily.SFPro.bold, size: 20))
            Spacer()
            
            HStack {
                Text("more")
                    .font(.custom(FontFamily.SFPro.regular, size: 16))
                Image(.moreIcon)
            }
        }
    }
}

#Preview {
    MangaSectionTitleView()
}
