//
//  Constants.swift
//  EMSwiftUI
//
//  Created by Kristina Grebneva on 05.03.2025.
//

import SwiftUI

// константы
// параметры верстки
enum Const {
    enum Text {
        static let largeSize: CGFloat = 20
        static let mediumSize: CGFloat = 16
        static let smallSize: CGFloat = 14
    }
    
    enum Layout {
        static let smallPadding: CGFloat = 4
        static let largePadding: CGFloat = 8
        static let gridPadding: CGFloat = 25
        static let imageRadius: CGFloat = 4
        static let buttonRadius: CGFloat = 8
        static let imageAspectRatio: CGFloat = 3/2
        static let moreButtonName = "more"
    }
    
    enum Colors {
        static let gray = Color.customGray
        static let black = Color.customBlack
    }
    
    enum Other {
        static let maxRating = 5
        static let maxMangaSectionNumber = 6
    }
    
    enum FilterScreen {
        static let navigationTitle = "Filters"
        static let sectionName = "Selection"
        static let applyButtonName = "Apply"
        static let resetButtonName = "Reset"
    }
}


