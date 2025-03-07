//
//  ImageExtension.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

extension Image {
    func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
    
    func resizedToFit(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
    }
    
    func resizedToFit() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    func resizedToFillAndRounded(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizedToFill(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: Const.Layout.imageRadius))
    }
    
    func resizedToFitAndRounded(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizedToFit(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: Const.Layout.imageRadius))
    }
}
