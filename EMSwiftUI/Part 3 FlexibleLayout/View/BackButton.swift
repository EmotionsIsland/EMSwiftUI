//
//  BackButton.swift
//  EMSwiftUI
//
//  Created by Алсу Хайруллина on 15.10.2024.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            dismiss()
            action?()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(.blackBase)
        }
    }
}
