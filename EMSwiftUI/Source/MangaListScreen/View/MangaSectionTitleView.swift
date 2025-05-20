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
        VStack {
            Text(title)
                .font(Font.SFPro.headline3)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
