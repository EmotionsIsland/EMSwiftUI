//
//  ViewExtension.swift
//  EMSwiftUI
//
//  Created by Максим Шишлов on 13.12.2024.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
}
