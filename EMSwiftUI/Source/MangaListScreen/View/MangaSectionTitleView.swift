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
        HStack {
            Text(sectionTitle.capitalized)
                .font(.SFPro.headline2)
            Spacer()
            Button { }
            label: {
                HStack {
                    Text("more")
                        .font(.SFPro.mediumNormal)
                    Image("moreIcon")
                }
                .foregroundStyle(.blackBase)
            }
        }
        .padding(.horizontal)
    }
}
