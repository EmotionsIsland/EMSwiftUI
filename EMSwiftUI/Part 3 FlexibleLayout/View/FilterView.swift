//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by User on 11.05.2024.
//

import SwiftUI


struct FilterView: View {
    @State private var selectedFilters = [Filter]()
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    HStack {
                        SingleFilters(viewModel: FilterViewModel(filters: selectedFilters), selectedFilters: $selectedFilters)
                        Spacer()
                    }
                    
                    VStack {
                        applyButton
                        Spacer()
                        resetButton
                    } .padding(.horizontal)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.grayBase)
                    
                    VStack {
                        SingleFilters(viewModel: FilterViewModel(filters: Filter.allFilters), selectedFilters: $selectedFilters)
                            .modifier(FilterTitleModifier(title: "Content Rating"))
                        
                        SingleFilters(viewModel: FilterViewModel(filters: Filter.allFilters), selectedFilters: $selectedFilters)
                            .modifier(FilterTitleModifier(title: "Publication Status"))
                        
                        SingleFilters(viewModel: FilterViewModel(filters: Filter.allFilters), selectedFilters: $selectedFilters)
                            .modifier(FilterTitleModifier(title: "Magazine Demographic"))
                        
                        SingleFilters(viewModel: FilterViewModel(filters: Filter.allFilters), selectedFilters: $selectedFilters)                         .modifier(FilterTitleModifier(title: "Format"))
                        
                        SingleFilters(viewModel: FilterViewModel(filters: Filter.allFilters), selectedFilters: $selectedFilters)
                            .modifier(FilterTitleModifier(title: "Theme"))
                    }
                } .navigationTitle("Selection")
            }
        }
    }
}

#Preview {
    FilterView()
}

private extension FilterView {
    var applyButton: some View {
        Button("Apply") {
            print("Apply was tapped")
        }
        .frame(maxWidth: .infinity, minHeight: 30)
        .background(Color(.orangeBase))
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .padding(.bottom, 8)
    }
    
    var resetButton: some View {
        Button("Reset") {
            selectedFilters.removeAll()
        } .foregroundStyle(.blackBase)
    }
}

// MARK: - Modifier
struct FilterTitleModifier: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        DisclosureGroup(title) {
            content
                .padding(.vertical)
        } .padding(.horizontal)
            .font(.title3)
            .foregroundStyle(.blackBase)
    }
}

// MARK: - Оставила закомментированным второй вариант. Знаю, что в нормальной версии быть не должно)
//    var contentRatingView: some View {
//        makeUnfoldingFilter(text: "Content Rating", isShowFilter: false)
//    }
//
//    var publicationStatusView: some View {
//        makeUnfoldingFilter(text: "Publication Status", isShowFilter: false)
//    }
//
//    var formatView: some View {
//        makeUnfoldingFilter(text: "Format", isShowFilter: false)
//    }
//
//    var genreView: some View {
//        makeUnfoldingFilter(text: "Genre", isShowFilter: false)
//    }
//
//    var magazineDemographicView: some View {
//        makeUnfoldingFilter(text: "Magazine Demographic", isShowFilter: true)
//    }
//
//    var themeView: some View {
//        makeUnfoldingFilter(text: "Theme", isShowFilter: true)
//    }
//
//    func makeUnfoldingFilter(text: String, isShowFilter: Bool) -> some View {
//        HStack {
//            Text(text)
//                .frame(alignment: .leading)
//                .padding([.leading, .top])
//                .font(.title3)
//            Image(.moreIcon)
//                .padding(.top)
//                .onTapGesture {
//                    if isShowFilter {
//                        isShowFilters.toggle()
//                    }
//                }
//            Spacer()
//        }
//    }
//}
