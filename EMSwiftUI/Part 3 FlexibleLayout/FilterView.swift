//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Combine

let title = "Selection"

struct FilterView: View {
    @StateObject private var model = FilterModel()

    var body: some View {
        print("🍎", #function, "VIEW UPDATED")
        Self._printChanges()
        return VStack {
            HStack {
                Text(title)
                    .labelStyle(.titleOnly)
                    .bold()
                    .font(.system(size: 20))
                    .padding([.leading, .trailing, .bottom], 16)
                Spacer()
            }.padding([.bottom], -30)

            ScrollView(.vertical) {
                FilterSectionView(items: model.items, model: model) { item in
                    model.items.removeAll(where: { $0 == item })
                    print("😈", #function, item)
                    print("😈", #function, model.items)
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
                model.items.removeAll()
            }, label: {
                Text("Reset")
                    .foregroundStyle(.black)
                    .font(.system(size: 16))
            })

            Separator()
            ExpandableListView(model: model) { item in
                    if model.items.contains(item) {
                        return
                    }
                    model.items.append(item)
                    print("😈", #function, item)
                    print("😈", #function, model.items)
                }
                Spacer()
        }
    }
}

#Preview {
    FilterView()
}
