//
//  FilterSectionHeader.swift
//  EMSwiftUI
//
//  Created by Глеб Поляков on 06.07.2025.
//

import SwiftUI

struct FilterSectionHeader: View {
    let sectionTitle: String
    let isExpanded: Bool
    var expand: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Text(sectionTitle.capitalized)
                .font(.SFPro.regularLarge)
            Button {
                expand()
            } label: {
                Image("expandDown")
                    .foregroundStyle(.blackBase)
                    .rotationEffect(isExpanded ? Angle(degrees: 180) : Angle(degrees: 0))
                    .animation(.bouncy, value: isExpanded)
            }
        }
    }
}
