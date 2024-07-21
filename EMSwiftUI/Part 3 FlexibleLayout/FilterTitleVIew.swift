//
//  FilterTitleVIew.swift
//  EMSwiftUI
//
//  Created by Никита Гладышев on 21.07.2024.
//

import SwiftUI

struct FilterTitleView: View {
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    HStack {
                        Text("Filters")
                            .font(FontFamily.SFPro.bold.swiftUIFont(size: 24))
                            .foregroundStyle(.blackBase)
                    }
                    
                    HStack() {
                        Spacer()
                        
                        Button {
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.blackBase)
                        }
                    }
                    .padding(.horizontal, 26)
                }
                
                Divider()
                    .foregroundStyle(.gray)
            }
        }
    }
}
