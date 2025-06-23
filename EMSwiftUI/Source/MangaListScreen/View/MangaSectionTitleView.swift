//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    let titleText: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(titleText)
                .font(.custom("SF-Pro-Text-Bold", size: 20))
            
            Spacer()
            
            moreButton(action)
        }
    }
}

private extension MangaSectionTitleView {
    func moreButton(_ action: @escaping () -> Void) -> some View {
        return Button(action: action) {
            HStack(spacing: 4) {
                Text("more")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MangaSectionTitleView(titleText: "Popular") {}
}
