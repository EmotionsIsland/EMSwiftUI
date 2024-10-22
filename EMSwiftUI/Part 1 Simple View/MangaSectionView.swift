//
//  MangaSectionView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionView: View {

    let items = Array(1...6)
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        HStack {
            MangaSectionTitleView()

            Spacer()

            Button(action: {

            }, label: {
                Text("more")
                    .foregroundStyle(.gray)
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            })
        }.padding([.leading, .trailing], 16)

            .frame(alignment: .topLeading)
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(items, id: \.self) { item in
                MangaSingleGridView()
            }
        }
        Spacer()
    }
}

#Preview {
    MangaSectionView()
}
