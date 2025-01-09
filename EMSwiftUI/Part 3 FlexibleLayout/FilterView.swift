//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Combine

private let title = "Selection"

struct FilterView: View {
    @StateObject private var filterItems = FilterItems()

    var body: some View {
        return VStack {
            Text(title)
                .labelStyle(.titleOnly)
                .bold()
                .font(.system(size: 20))
                .padding([.leading, .trailing, .bottom], 16)

            ScrollView(.vertical) {
                FilterSectionView(items: filterItems.items, filterItems: filterItems) { item in
                    filterItems.items.removeAll(where: { $0 == item })
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
                filterItems.items.removeAll()
            }, label: {
                Text("Reset")
                    .foregroundStyle(.black)
                    .font(.system(size: 16))
            })

            Separator()
            ExpandableListView(filterItems: filterItems) { item in
                if !filterItems.items.contains(item) {
                    filterItems.items.append(item)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    FilterView()
}
