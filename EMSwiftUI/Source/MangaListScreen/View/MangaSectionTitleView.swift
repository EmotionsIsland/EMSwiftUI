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
        HStack {
            Text(title)
                .font(Font.SFPro.semiboldNormal)
            
            Spacer()
            
            Button(action: {
                print("tap more")
            }, label: {
                HStack {
                    Text("more")
                        .font(Font.SFPro.mediumNormal)
                    
                    Image("moreIcon")
                }
            })
        }
    }
}
