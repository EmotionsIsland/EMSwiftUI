//
//  SearchBarView.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 20.02.2026.
//

import SwiftUI

struct SearchBarView: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 2) {
                Image(.search)
                    .resizedToFill(width: 24, height: 24)
                    .padding(.vertical, 6)
                
                TextField("Search", text: .constant(""))
                    .font(.SFPro.lightSmall)
            }
            .foregroundColor(.grayBase)
            .padding(.horizontal, 4)
            .frame(height: 36)
            .background(Color(red: 237/255, green: 238/255, blue: 242/255))
            .cornerRadius(8)
            .padding(.horizontal, 16)
            
            Divider()
                .background(.grayBase)
        }
    }
}
