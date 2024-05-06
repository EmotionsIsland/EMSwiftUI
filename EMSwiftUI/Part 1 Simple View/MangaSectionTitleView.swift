//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    var sectionName: LocalizedStringKey
    
    var body: some View {
        HStack(alignment: .center) {
            Text(sectionName)
                .font(.custom(FontFamily.SFPro.bold, size: 20))
                .foregroundStyle(.blackBase)
            
            Spacer()
            
            Button {
                print("open \(sectionName)")
            } label: {
                HStack(alignment: .center, spacing: 8) {
                    Text("more")
                        .font(.custom(FontFamily.SFPro.regular, size: 16))
                        .foregroundStyle(.blackBase)
                    
                    Image(.moreIcon)
                        .foregroundStyle(.blackBase)
                }
            }
        }
    }
}

#Preview {
    MangaSectionTitleView(sectionName: "Popular")
}
