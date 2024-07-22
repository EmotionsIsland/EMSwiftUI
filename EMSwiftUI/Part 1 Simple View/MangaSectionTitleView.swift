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
        HStack() {
            titleLabel
            
            Spacer()
            
            HStack(alignment: .center,spacing: 8) {
                moreButtonTitle
                
                moreButton
            }
        }
        .padding(.horizontal, 16)
    }
}

private extension MangaSectionTitleView {
    var titleLabel: some View {
        Text(title)
            .font(FontFamily.SFPro.bold.swiftUIFont(size: 20))
            .foregroundStyle(.blackBase)
    }
    
    var moreButtonTitle: some View {
        Text("more")
            .font(FontFamily.SFPro.regular.swiftUIFont(size: 16))
            .foregroundStyle(.blackBase)
    }
    
    var moreButton: some View {
        Button{
        } label: {
            Image("moreIcon")
                .resizedToFill(width: 24, height: 28)
                .foregroundStyle(.blackBase)
        }
    }
}
