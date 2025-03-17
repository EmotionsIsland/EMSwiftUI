//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    @State private var filtersData: [String: [String]] = [:]
    @State private var pickedFiltersData = Set<String>()
    
    typealias Const = MangaListMainScreenModel.Const
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    selection
                    Divider()
                    filters
                    Spacer()
                }
            }
            .padding()
            .navigationTitle(Const.FilterScreen.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: { Asset.Icons.back.swiftUIImage })
            }
        }
        .onAppear {
            filtersData = getFilters()
        }
    }
    
    @ViewBuilder
    private var selection: some View {
        if pickedFiltersData.isNotEmpty {
            VStack(alignment: .leading) {
                Divider()
                HStack {
                    Text(Const.FilterScreen.sectionName)
                        .font(.custom(FontFamily.SFPro.bold,
                                      size: Const.Text.largeSize))
                    Spacer()
                }
                
                pickedFilters
                    .padding(Const.Layout.smallPadding)
                
                applyButton
                resetButton
            }
        }
    }
    
    private var pickedFilters: some View {
        FlexibleLayout(array: Array(pickedFiltersData)) { filter in
            Text("+ \(filter)")
                .oranged()
        }
    }
    
    private var applyButton: some View {
        Button(action: {}) {
            Text(Const.FilterScreen.applyButtonName)
                .padding(Const.Layout.smallPadding)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .orangeButtonStyle(color: Asset.Colors.orangeBase.swiftUIColor)
    }
    
    private var resetButton: some View {
        Button(action: removeAllFilters) {
            Text(Const.FilterScreen.resetButtonName)
                .padding(Const.Layout.smallPadding)
                .frame(maxWidth: .infinity)
                .foregroundColor(Asset.Colors.blackBase.swiftUIColor)
                .contentShape(Rectangle())
        }
    }
    
    private var filters: some View {
        VStack(alignment: .leading) {
            ForEach(Array(filtersData.keys.sorted(by: {$0 < $1})), id: \.self) { category in
                OneCategoryFilterView(category: category, 
                                      filters: filtersData[category] ?? [],
                                      addFilterAction: pickFilter(_:),
                                      checkPickingAction: checkPicking(_:)
                )
            }
        }
    }
    
    // MARK: - Intents
    private func pickFilter(_ filter: String) {
        pickedFiltersData.insert(filter)
    }
    
    private func checkPicking(_ filter: String) -> Bool {
        return pickedFiltersData.contains(filter)
    }
    
    private func removeAllFilters() {
        pickedFiltersData.removeAll()
    }
    
    private func getFilters() -> [String:[String]] {
        var mockFilters: [String: [String]] = [:]
        mockFilters["Content Rating"] = ["All Ages", "Teen (13+)", "Mature (17+)", "Explicit (18+)"]
        mockFilters["Publication Status"] = ["Ongoing", "Completed", "Hiatus", "Cancelled"]
        mockFilters["Magazine Demographic"] = ["Young boys", "Young girls", "Adult men", "Adult women", "Children"]
        mockFilters["Format"] = ["Manga", "One-Shot", "Light Novel", "Doujinshi", "Webtoon", "Anthology"]
        mockFilters["Genre"] = ["Action", "Romance", "Comedy", "Horror", "Fantasy", "Sci-Fi", "Slice of Life"]
        mockFilters["Theme"] = ["Adventure", "Supernatural", "Psychological", "Historical", "Sports", "Mystery"]
        return mockFilters
    }
}

#Preview {
    FilterView()
}
