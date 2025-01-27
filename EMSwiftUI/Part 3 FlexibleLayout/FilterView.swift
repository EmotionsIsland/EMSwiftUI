//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

private let title = "Selection"

struct FilterView: View {
    @State private var filteredItems: [String] = []
    @State private var items: [String] = []

    var body: some View {
        return VStack {
            Text(title)
                .labelStyle(.titleOnly)
                .bold()
                .font(.system(size: 20))
                .padding([.leading, .trailing, .bottom], 16)

            ScrollView(.vertical) {
                FilterSectionView(items: filteredItems, filteredItems: $filteredItems) { item in
                    filteredItems.removeAll(where: { $0 == item })
                }
            }.padding([.bottom], 8)
                .frame(minHeight: 50 ,maxHeight: 220)

            Button(action: {

            }, label: {
                ZStack {
                    Rectangle()
                        .fill(Color.red.opacity(0.9))
                        .cornerRadius(8)
                        .frame(height: 44)
                        .padding([.leading, .trailing], 16)
                    Text("Apply")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                }
            })

            Button(action: {
                filteredItems.removeAll()
                items.removeAll()
            }, label: {
                Text("Reset")
                    .foregroundStyle(.black)
                    .font(.system(size: 16))
            })

            Separator()
            ExpandableListView(filteredItems: $filteredItems) { item in
                if !filteredItems.contains(item) {
                    filteredItems.append(item)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    FilterView()
}
