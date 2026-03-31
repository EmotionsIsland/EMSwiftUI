//
//  Buttons.swift
//  EMSwiftUI
//
//  Created by Анатолий Чириков on 24.03.2026.
//

import SwiftUI

struct Buttons: View {
    let onReset: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: {
                print("Tapped")
            }, label: {
                Text("Apply")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orangeBase)
                    .foregroundStyle(Color(.white))
                    .cornerRadius(8)
            })
            Button(action: onReset,
                   label: {
                Text("Reset")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(Color.blackBase)
            })
        }
        .padding(.top, 8)
    }
}
