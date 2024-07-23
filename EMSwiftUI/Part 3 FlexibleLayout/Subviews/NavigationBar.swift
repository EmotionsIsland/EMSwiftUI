//
//  NavigationBar.swift
//  EMSwiftUI
//
//  Created by Vladislav Miroshnichenko on 14.07.2024.
//

import SwiftUI

struct NavigationBar<Content: View>: View {
    
    var rightBarItems: (() -> Content)?
    var leftBarItems: (() -> Content)?
    let title: String
    
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: 8) {
                    rightBarItems?()
                    Spacer()
                }
                .padding(.leading, 16)
                
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(FontFamily.SFProText.bold.swiftUIFont(size: 24))
                    .foregroundStyle(Color.blackBase)
                
                HStack(spacing: 8) {
                    Spacer()
                    leftBarItems?()
                }.padding(.trailing, 16)
                
            }.padding(.vertical, 8)
        }
        Divider()
    }
    
    public init(_ title: String,
                rightBarItems: (() -> Content)? = nil,
                leftBarItems: (() -> Content)? = nil) {
        self.title = title
        self.rightBarItems = rightBarItems
        self.leftBarItems = leftBarItems
    }
    
}
