//
//  HeaderView.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 19.02.2026.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            ZStack {
                Text("Filters")
                    .font(.SFPro.headline2)
                    .padding(.vertical, 11)
                
                HStack(alignment: .center) {
                    Spacer()
                    Button(action: {}, label: {
                        Image(.close)
                            .resizedToFill(width: 30, height: 30)
                    })
                    .padding(.trailing, 16)
                }
            }
            .foregroundStyle(.blackBase)
            
            Divider()
                .background(.grayBase)
        }
    }
}
