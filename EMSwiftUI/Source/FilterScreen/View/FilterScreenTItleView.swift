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
    var dismiss: () -> Void
    
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
                            .foregroundStyle(Color.init(cgColor: #colorLiteral(red: 0.2834452093, green: 0.2834451795, blue: 0.2834452093, alpha: 1)))
                    }
                    .padding(.horizontal, 16)
                }
            }
            Divider()
                .foregroundStyle(Color.init(cgColor: #colorLiteral(red: 0.8110429645, green: 0.8110429049, blue: 0.8110429049, alpha: 1)))
                .padding(.top, 8)
        }
    }
}

#Preview {
    FilterScreenTitleView(title: "Filters", dismiss: {})
}
