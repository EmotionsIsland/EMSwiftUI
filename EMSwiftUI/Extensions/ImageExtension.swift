//
//  ImageExtension.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

extension Image {
    typealias Const = MangaListMainScreenModel.Const

    func resizedToFill(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
    
    func resizedToFit(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
    }
    
    func resizedToFillAndRounded(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        self
            .resizable()
            .aspectRatio(Const.Layout.imageAspectRatio, contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: Const.Layout.imageRadius))
    }
}
