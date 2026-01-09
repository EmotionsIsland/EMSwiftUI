//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    var title: String
    var showMore: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .bold))
            
            Spacer()
            Button(action: showMore) {
                HStack(spacing: 8) {
                    Text("more")
                        .font(.system(size: 16, weight: .regular))
                    Image(systemName: "chevron.right")
                }
            }.foregroundStyle(.black)
        }
    }
}
