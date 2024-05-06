//
//  FilterOptionsGridView.swift
//  EMSwiftUI
//
//  Created by Alex on 5.05.24.
//

import SwiftUI

struct FilterOptionsGridView: View {
    @Binding var selectedOptions: [String]
    var availibleOptions: [String]

    var body: some View {
        ScrollView {
            FlowLayout(items: availibleOptions) { option in
                FilterOptionView(isSelected: selectedOptions.contains(option), text: option) {
                    withAnimation(.easeInOut(duration: 1)) {
                        if selectedOptions.contains(option) {
                            selectedOptions.removeAll(where: { $0 == option})
                        } else {
                            selectedOptions.append(option)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FilterOptionsGridView(selectedOptions: .constant(["Shounen", "Shoujo"]), availibleOptions: ["Shounen", "Shoujo", "Seinen", "Josei", "None", "Any"])
}
