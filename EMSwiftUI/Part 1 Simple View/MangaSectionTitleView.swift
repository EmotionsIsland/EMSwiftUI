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
            // TODO: Create section title View
            HStack{
                Text(title)
                    .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                    .font(.custom(FontFamily.SFPro.bold, size: 20))
                Spacer()
                Button(action: {
                    
                }, label: {
                    HStack{
                        Text("more")
                            .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                            .font(.custom(FontFamily.SFPro.regular, size: 16))
                        Asset.Icons.moreIcon.swiftUIImage
                            .foregroundStyle(.black)
                    }
                })
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MangaSectionTitleView(title: "Popular")
}
