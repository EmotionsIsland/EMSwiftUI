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
    
    func resizedToFit() -> some View {
        self
            .resizable()
            .frame(maxHeight: .infinity) // Занимает всю высоту контейнера
            .scaledToFit()
    }
}
