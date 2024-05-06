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
            sectionTitle(title: title)
            
            Spacer()
            
            moreButton()
        }
    }
}

private extension MangaSectionTitleView {
    func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.title3)
            .bold()
    }
    
    func moreButton() -> some View {
        Button(action: { }) {
            HStack(spacing: 10) {
                Text("more")
                
                Image(systemName: "chevron.right")
            }
        }
    }
}

