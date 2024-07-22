//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {
    
    //MARK: - Private properties
    
    @EnvironmentObject private var viewModel: MangaListViewModel
    
    //MARK: - UI
    
    var body: some View {
        VStack {
            HStack{
                Text(StringConstants.title)
                    .font(Fonts.label)
                Spacer()
                Button {
                    
                } label: {
                    Text(StringConstants.moreButtonTitle)
                        .font(Fonts.buttonTitle)
                        .tint(Colors.moreButton)
                    Image(Images.moreButton)
                        .tint(Colors.moreButton)
                }
            }
        }
    }
}

//MARK: - Extension with private subobject

private extension MangaSectionTitleView {
    
    enum Fonts {
        static let label = FontFamily.SFProText.bold.swiftUIFont(size: 20)
        static let buttonTitle = FontFamily.SFPro.regular.swiftUIFont(size: 16)
    }
    
    enum Colors {
        static let moreButton = Color.blackBase
    }
    
    enum StringConstants {
        static let title = "Popular"
        static let moreButtonTitle = "more"
    }
    
    enum Images {
        static let moreButton = ImageResource.moreIcon
    }
    
}

#Preview {
    MangaSectionTitleView()
        .environmentObject(MangaListViewModel())
}
