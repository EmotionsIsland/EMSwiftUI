//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @State private var filters: Set<String> = ["11", "I", "3", "I", "I5", "Item 6", "Item 7", "Item 66668", "Item 9", "Item 10", "Item 11", "Item 12", "Item 44" ]
    @State private var selectedFilters: Set<String> = []
    @State private var isShowFilters = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 8) {
                    ForEach(selectedFilters.sorted(), id: \.self) { selectedItem in
                        Text("+   \(selectedItem)")
                            .padding(5)
                            .foregroundStyle(.white)
                            .background(Color.orangeBase)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                VStack {
                    Button("Apply") {
                        print("Apply was tapped")
                    }
                    .frame(maxWidth: .infinity, minHeight: 30)
                    .background(Color(.orangeBase))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .padding(.bottom, 8)
                    Spacer()
                    
                    Button("Reset") {
                        selectedFilters.removeAll()
                    } .foregroundStyle(.blackBase)
                } .padding(.horizontal)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.grayBase)
                
                VStack {
                    HStack(spacing: 4) {
                        Text("Content Rating")
                            .frame(alignment: .leading)
                            .padding(.leading)
                            .padding(.top)
                            .font(.title3)
                        Image(.moreIcon)
                            .padding(.top)
                        Spacer()
                    }
                    
                    HStack(spacing: 4) {
                        Text("Publication Status")
                            .frame(alignment: .leading)
                            .padding(.leading)
                            .padding(.top)
                            .font(.title3)
                        Image(.moreIcon)
                            .padding(.top)
                        Spacer()
                    }
                    
                    HStack(spacing: 4) {
                        Text("Magazine Demographic")
                            .frame(alignment: .leading)
                            .padding(.leading)
                            .padding(.top)
                            .font(.title3)
                        Image(.moreIcon)
                            .padding(.top)
                            .onTapGesture {
                                isShowFilters.toggle()
                            }
                        Spacer()
                    }
                    
                    if isShowFilters {
                        LazyHGrid(rows: [GridItem](repeating: GridItem(), count: 2)) {
                            ForEach(filters.sorted(), id: \.self) { filter in
                                Button(action: {
                                    if selectedFilters.contains(filter) {
                                        selectedFilters.remove(filter)
                                    } else {
                                        selectedFilters.insert(filter)
                                    }
                                }) {
                                    let buttonText = !selectedFilters.contains(filter) ? filter : "+ \(filter)"
                                    Text(buttonText)
                                        .padding(5)
                                        .background(selectedFilters.contains(filter) ? Color.orangeBase : Color.grayBase)
                                        .foregroundColor(.black)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                }
                            }
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Text("Format")
                            .frame(alignment: .leading)
                            .padding(.leading)
                            .padding(.top)
                            .font(.title3)
                        Image(.moreIcon)
                            .padding(.top)
                        Spacer()
                    }
                    HStack(spacing: 4) {
                        Text("Genre")
                            .frame(alignment: .leading)
                            .padding(.leading)
                            .padding(.top)
                            .font(.title3)
                        Image(.moreIcon)
                            .padding(.top)
                        Spacer()
                    }
                    HStack(spacing: 4) {
                        Text("Theme")
                            .frame(alignment: .leading)
                            .padding(.leading)
                            .padding(.top)
                            .font(.title3)
                        Image(.moreIcon)
                            .padding(.top)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Selection")
        }
    }
}


#Preview {
    FilterView()
}
