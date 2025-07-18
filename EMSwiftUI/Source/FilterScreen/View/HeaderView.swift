//
//  HeaderView.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/18/25.
//

import SwiftUI

struct HeaderView: View {
    var isUnfolded: Bool
    let groupTitle: String
    let action: () -> ()
    
    var body: some View {
        HStack(spacing: 8) {
            Text(groupTitle)
                .font(.custom("SFProDisplay-Regular", size: 20))
            Button {
                action()
            } label: {
                Image(
                    systemName: isUnfolded ? "chevron.up" : "chevron.down"
                )
            }
        }
        .foregroundStyle(Color.blackBase)
        .animation(
            .spring(response: 0.4, dampingFraction: 0.7),
            value: isUnfolded
        )
    }
}
