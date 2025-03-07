//
//  MainView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/12/23.
//

import SwiftUI

struct MainView: View {
    let headers = ["Header1", "Header2", "Header3", "Header4"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(headers, id: \.self) { index in
                MangaSectionView()
                    .padding(.bottom, 24)
            }
        }
    }
}

#Preview {
    MainView()
}
