//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    
    //MARK: - Private property

    private let data: MangaData
    private let image: URL
    private let maxRaiting = 5
    
    //MARK: - UI
    
    var body: some View {
        VStack(spacing: 4) {
            AsyncImage(url: image) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 144)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
            } placeholder: {
                RoundedRectangle(cornerRadius: 4.0).fill( Colors.imagebackground)
                    .frame(width: 100, height: 144)
            }
            
            VStack(alignment: .leading, spacing: 2){
                Text(data.attributes.title.en ?? StringConstants.unknownTitle)
                    .font(Fonts.title)
                    .lineLimit(1)
                    .foregroundStyle(Colors.title)
                
                RatingView(rating: CGFloat.random(in: 0...4),
                           maxRating: maxRaiting)
                
                Text(data.attributes.tags
                    .compactMap { $0.attributes.name.en }
                    .joined(separator: ",")
                )
                    .font(Fonts.genres)
                    .lineLimit(1)
                    .foregroundStyle(Colors.genres)
                    
                    
            }
        }
    }
    
    //MARK: - Initialaizers
    
    public init(image: URL, data: MangaData) {
        self.image = image
        self.data = data
    }
    
}

//MARK: - Extension with private subobjects

private extension MangaSingleGridView {
    
    enum Colors {
        static let title = Color.blackBase
        static let genres = Color.grayBase
        static let imagebackground = Color.grayBase
    }
    
    enum StringConstants {
        static let unknownTitle = "No title"
    }
    
    enum Fonts {
        static let title = FontFamily.SFPro.semibold.swiftUIFont(size: 16)
        static let genres = FontFamily.SFPro.light.swiftUIFont(size: 14)
    }
    
}

extension MangaData {
    
    public static var mock: MangaData {
        MangaData(id: "1234",
                  type: "Manga",
                  attributes: .init(
                    title: .init(en: "Monster"),
                    altTitles: [],
                    description: .init(en: "",
                                       ru: nil),
                    isLocked: false,
                    originalLanguage: "",
                    publicationDemographic: "",
                    status: "",
                    year: 2005,
                    contentRating: "",
                    tags: [.init(id: "1234", 
                                 type: "Type",
                                 attributes: .init(name: .init(en: "Tag"),
                                                                            group: "Group"))],
                    state: "",
                    createdAt: "",
                    updatedAt: "",
                    version: 4,
                    availableTranslatedLanguages: []),
                  relationships: [])
    }
    
}

#Preview {
    MangaSingleGridView(image: URL(string: "")!, data: MangaData.mock)
    .frame(width: 100)
}

