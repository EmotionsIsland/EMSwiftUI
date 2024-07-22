//
//  MangaType.swift
//  EMSwiftUI
//
//  Created by Vladislav Miroshnichenko on 18.07.2024.
//

import Foundation

enum MangaType: CustomStringConvertible {
    case ContentRaiting
    case PublicationStatus
    case MagazineDemographic
    case Format
    case Genre
    case Theme
    
    var description: String {
        switch self {
        case .ContentRaiting: "Content Raiting"
        case .PublicationStatus: "Publication Status"
        case .MagazineDemographic: "Magazine Demographic"
        case .Format: "Format"
        case .Genre: "Genre"
        case .Theme: "Theme"
        }
    }
}
