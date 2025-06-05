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
        ZStack {
            Text(sectionTitle)
                .font(.SFPro.headline3)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
