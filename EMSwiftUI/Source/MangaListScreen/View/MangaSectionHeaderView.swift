//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionHeaderView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("SFProText-Bold", size: 20))
                .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
            
            Spacer()
            
            HStack(spacing: 8) {
                Text("more")
                    .font(.custom("SFProDisplay-Regular", size: 16))
                    .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                
                Image("moreIcon")
                    .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
            }
        }
        .padding(.bottom, 16)
        .padding(.top, 20)
    }
}
