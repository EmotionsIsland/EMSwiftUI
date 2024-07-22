//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    
    //MARK: - Private properties
    
    private var tags: [FilterModel] = [
        .init(type: .ContentRaiting, tags: [
            "Everyone", "Youth", "Teens", "Older Teens", "Mature"
        ]),
        .init(type: .PublicationStatus,
              tags: ["Ongoing", "Finished", "Debut"]),
        .init(type: .MagazineDemographic,
              tags: ["Children", "Shonen", "Shojo", "Seinen", "Josei"]),
        .init(type: .Format, tags: ["Сollection", "In color", "Dojinshi", "Webtoon", "Single"]),
        .init(type: .Genre, tags: ["Comedy", "Mecha", "Cooking", "Slice", "Isekai"]),
        .init(type: .Theme, tags: ["Comedies", "Romances", "Adventure stories", "Detective stories", "Historical", "Chivalrous stories"])
        
    ]

    @State private var selection: [String] = []
    
    //MARK: - UI
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationBar(StringConstants.navigationViewTitle, leftBarItems:  {
                Button {

                } label: {
                    Image(systemName: StringConstants.xMarkImageName)
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.blackBase)
                }
                .frame(width: 30, height: 30)
                
            })
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(StringConstants.selectionSectionTitle)
                        .font(FontFamily.SFProText.bold.swiftUIFont(size: 20))
                        .foregroundStyle(.blackBase)
                    
                    TagsView(data: selection) { element in
                        TagsViewItem(title: element, isSelected: true)
                    }
                    
                    VStack(alignment: .center, spacing: 8) {
                        Button(StringConstants.applyButtonTitle) {
                            
                        }
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .tint(Color.whiteText)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(Color.orangeBase)
                        )
                        
                        Button(StringConstants.resetButtonTitle) {
                            selection.removeAll()
                        }
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .tint(Color.blackBase)
                    }
                    
                }.padding(.horizontal)
                
                DropDownView(data: tags, selection: $selection)
                
            }
            
        }
    }
    
}

//MARK: - Extension with private subobjects

private extension FilterView {
    
    enum StringConstants {
        static let navigationViewTitle = "Filters"
        static let selectionSectionTitle = "Selection"
        static let applyButtonTitle = "Apply"
        static let resetButtonTitle = "Reset"
        static let xMarkImageName = "xmark"
    }
    
}

#Preview {
    FilterView()
}
