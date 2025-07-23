//
//  FilterScreenTItleView.swift
//  EMSwiftUI
//
//  Created by Новгородцев Никита on 22/07/2025.
//

import Foundation
import SwiftUI

struct FilterScreenTitleView: View {
    let title: String
    let dismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(title)
                    .font(.SFPro.headline2)
                
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image("close")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.blackBase)
                    }
                    .padding(.horizontal, 16)
                }
            }
            Divider()
                .foregroundStyle(Color.whiteText)
                .padding(.top, 8)
        }
    }
}

#Preview {
    FilterScreenTitleView(title: "Filters", dismiss: {})
}
