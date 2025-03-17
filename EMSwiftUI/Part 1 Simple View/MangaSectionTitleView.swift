//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    let sectionTitle: String
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(sectionTitle)
                    .font(.custom(FontFamily.SFPro.bold, size: 20))
                Spacer()
                HStack(alignment: .center) {
                    Text("more")
                    Image(.moreIcon)
                }
            }
        }
        .padding(.horizontal)
    }
}
