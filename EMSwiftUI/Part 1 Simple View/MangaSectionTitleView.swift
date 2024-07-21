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
            Text(title)
                .font(FontFamily.SFPro.bold.swiftUIFont(size: 20))
                .foregroundStyle(.blackBase)
            
            Spacer()
            
            HStack(alignment: .center,spacing: 8) {
                Text("more")
                    .font(FontFamily.SFPro.regular.swiftUIFont(size: 16))
                    .foregroundStyle(.blackBase)
                
                Button{
                } label: {
                    Image("moreIcon")
                        .resizable()
                        .frame(
                            width: 24,
                            height: 28
                        )
                        .foregroundStyle(.blackBase)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
