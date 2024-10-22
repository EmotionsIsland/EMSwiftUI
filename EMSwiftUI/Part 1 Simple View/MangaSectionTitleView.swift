//
//  MangaSectionTitleView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSectionTitleView: View {

    let title: String = "Temporary title"
    
    var body: some View {
        HStack {
            Text(title)
                .labelStyle(.titleOnly)
        }
    }
}

#Preview {
    MangaSectionTitleView()
}
