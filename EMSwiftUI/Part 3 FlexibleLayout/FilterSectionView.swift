//
//  FilterSectionView.swift
//  EMSwiftUI
//
//  Created by Alex on 5.05.24.
//

import SwiftUI

struct FilterSectionView: View {
    @Binding var selectedOptions: [String]
    var availibleOptions: [String]
    var sectionName: String
    
    @State private var isOpened = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                isOpened.toggle()
            } label: {
                HStack(alignment: .center, spacing: 8) {
                    Text(sectionName)
                        .font(.custom(FontFamily.SFPro.regular, size: 20))
                    
                    Image(.moreIcon)
                        .rotationEffect(.degrees(90))
                        .rotation3DEffect(
                            .degrees(isOpened ? 180 : 0),
                            axis: (x: 1.0, y: 0.0, z: 0.0)
                        )
                    Spacer(minLength: 0)
                }
            }.foregroundStyle(.foreground)
            if isOpened {
                FilterOptionsGridView(selectedOptions: $selectedOptions, availibleOptions: availibleOptions)
                    .transition(
                        .asymmetric(
                            insertion: .opacity,
                            removal: .opacity.animation(.easeIn(duration: 0.1))
                        )
                    )
            }
        }
        .animation(.easeInOut, value: isOpened)
    }
}

#Preview {
    VStack {
        FilterSectionView(selectedOptions: .constant(["Shounen", "Shoujo"]), availibleOptions: ["Shounen", "Shoujo", "Seinen", "Josei", "None", "Any"], sectionName: "Genre")
        Spacer()
    }
}
