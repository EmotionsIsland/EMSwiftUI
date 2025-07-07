//
//  FilterSingleGridView.swift
//  EMSwiftUI
//
//  Created by Глеб Поляков on 06.07.2025.
//

import SwiftUI

struct FilterSingleGridView: View {
    let tagTitile: String
    var isPicked: Bool
    var didTap: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            if isPicked {
                Image(systemName: "plus")
            }
            Text(tagTitile)
                .font(.SFPro.bodyNormal)
        }
        .foregroundStyle(.whiteText)
        .padding(8)
        .background(isPicked ? .orangeBase : .grayBase)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            withAnimation {
                didTap()
            }
        }
    }
}
