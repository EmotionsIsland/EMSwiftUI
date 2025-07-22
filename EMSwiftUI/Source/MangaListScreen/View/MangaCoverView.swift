//
//  CoverView.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/13/25.
//

import SwiftUI

struct MangaCoverView: View {
    let url: URL
    
    var body: some View {
        VStack {
            AsyncImage(url: url)
        }
    }
}
