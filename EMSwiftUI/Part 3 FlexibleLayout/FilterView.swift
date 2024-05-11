//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by User on 11.05.2024.
//

import SwiftUI


struct FilterView: View {
    let allFilters: [Filter] = [
        Filter(name: "Filter 1"),
        Filter(name: "Filter 2"),
        Filter(name: "Filter 3scdcsafefdfvsdcs"),
        Filter(name: "Filter 4"),
        Filter(name: "Filter 5"),
        Filter(name: "Filter 6"),
        Filter(name: "Filter 7"),
        Filter(name: "Filter 8"),
        Filter(name: "Filter 9csc"),
        Filter(name: "Filter 10"),
        Filter(name: "Filter 11"),
        Filter(name: "Filter asc12"),
        Filter(name: "Filter 13"),
        Filter(name: "Filter 14"),
        Filter(name: "Filter 15"),
        Filter(name: "Filter 16"),
        Filter(name: "Filter 17"),
        Filter(name: "Filter 18zz"),
        Filter(name: "Filter 19"),
        Filter(name: "Filter 20")
    ]
    @State private var selectedFilters = [Filter]()
    @State private var isShowFilters = false
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    HStack {
                        Filters(filters: selectedFilters, selectedFilters: $selectedFilters)
                        Spacer()
                    }
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
                            Filters(filters: allFilters, selectedFilters: $selectedFilters)
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
}

#Preview {
    FilterView()
}
