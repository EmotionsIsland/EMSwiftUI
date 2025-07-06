//
//  FilterScreen.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterScreen: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem()], alignment: .leading) {
                ForEach(0..<6) { _ in
                    Section {
                        // FilterSectionView()
                    } header: {
                        Text("Selection")
                            .font(.SFPro.headline2)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    FilterScreen()
}
