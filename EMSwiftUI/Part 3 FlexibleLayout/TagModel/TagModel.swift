//
//  TagModel.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 14.03.2025.
//

import Foundation

struct TagStruct: Equatable {
    let title: String
    let tag: String
    var isSelected: Bool = false
}

extension TagStruct {
    static var tags: [String: [TagStruct]] {
        [
            "Stars": [
                TagStruct(title: "Stars", tag: "Sirius"),
                TagStruct(title: "Stars", tag: "Canopus"),
                TagStruct(title: "Stars", tag: "Arcturus"),
                TagStruct(title: "Stars", tag: "Alpha centauri"),
                TagStruct(title: "Stars", tag: "Vega"),
                TagStruct(title: "Stars", tag: "Capella"),
                TagStruct(title: "Stars", tag: "Rigel"),
                TagStruct(title: "Stars", tag: "Procyon"),
                TagStruct(title: "Stars", tag: "Betelgeuse"),
                TagStruct(title: "Stars", tag: "Altair")
            ],
            "Planets": [
                TagStruct(title: "Planets", tag: "Mercury"),
                TagStruct(title: "Planets", tag: "Venus"),
                TagStruct(title: "Planets", tag: "Earth"),
                TagStruct(title: "Planets", tag: "Mars"),
                TagStruct(title: "Planets", tag: "Jupiter"),
                TagStruct(title: "Planets", tag: "Saturn"),
                TagStruct(title: "Planets", tag: "Uranus"),
                TagStruct(title: "Planets", tag: "Neptune")
            ],
            "Galaxies": [
                TagStruct(title: "Galaxies", tag: "Andromeda Galaxy"),
                TagStruct(title: "Galaxies", tag: "Milky Way (Our home galaxy)"),
                TagStruct(title: "Galaxies", tag: "Sombrero Galaxy"),
                TagStruct(title: "Galaxies", tag: "Pinwheel Galaxy"),
                TagStruct(title: "Galaxies", tag: "Black Eye Galaxy"),
                TagStruct(title: "Galaxies", tag: "Cigar Galaxy"),
                TagStruct(title: "Galaxies", tag: "Bode's Galaxy"),
                TagStruct(title: "Galaxies", tag: "Cartwheel Galaxy"),
                TagStruct(title: "Galaxies", tag: "Large Magellanic Cloud"),
                TagStruct(title: "Galaxies", tag: "Small Magellanic Cloud"),
            ],
            "Comets": [
                TagStruct(title: "Comets", tag: "Halley's Comet"),
                TagStruct(title: "Comets", tag: "Comet Hale-Bopp"),
                TagStruct(title: "Comets", tag: "Comet Hyakutake"),
                TagStruct(title: "Comets", tag: "Comet Ikeya-Seki"),
                TagStruct(title: "Comets", tag: "Comet McNaught"),
                TagStruct(title: "Comets", tag: "Comet Bennett"),
                TagStruct(title: "Comets", tag: "Comet Donati"),
            ]
        ]
    }
    
    static var defaultTag: TagStruct {
        TagStruct(title: "Default title", tag: "Default tag")
    }
}
