//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { _ in
                Image("starIcon")
                    .resizable()
                    .frame(width: 17,height: 17)
                    .foregroundStyle(.yellow)
            }
        }
    }
}
