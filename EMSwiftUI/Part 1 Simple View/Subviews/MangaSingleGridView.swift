//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {

    private let image: URL
    private let maxRaiting = 5
    
    @ObservedObject var viewModel: MangaGridViewModel
    
    var body: some View {
        VStack(spacing: 4) {
            AsyncImage(url: image) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 144)
                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
            } placeholder: {
                RoundedRectangle(cornerRadius: 4.0).fill( Colors.imagebackground)
                    .frame(width: 100, height: 144)
            }
            
            VStack(alignment: .leading, spacing: 2){
                Text(viewModel.data.attributes.title.en ?? StringConstants.unknownTitle)
                    .font(Fonts.title)
                    .lineLimit(1)
                    .foregroundStyle(Colors.title)
                
                RatingView(rating: CGFloat.random(in: 0...4),
                           maxRating: maxRaiting)
                
                Text(viewModel.getTags())
                    .font(Fonts.genres)
                    .lineLimit(1)
                    .foregroundStyle(Colors.genres)
                    
                    
            }
        }
    }

    public init(image: URL, viewModel: MangaGridViewModel) {
        self.image = image
        self.viewModel = viewModel
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

#Preview {
    MangaSingleGridView(image: URL(string: "")!,
                        viewModel: MangaGridViewModel(data: MangaData.mock)
    )
    .frame(width: 100)
}

