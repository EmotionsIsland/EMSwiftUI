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
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                print("Show more \(title)")
            }) {
                Text("more")
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
        }
    }
}
