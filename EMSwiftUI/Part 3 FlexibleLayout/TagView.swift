//
//  TagView.swift
//  EMSwiftUI
//
//  Created by Гриша Шкробов on 04.03.2025.
//

import SwiftUI

struct TagView: View {
    
    @State var tagName: String
    
    init(_ tagName: String, action: @escaping () -> ()) {
        self.tagName = tagName
        self.action = action
    }
    
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("+ \(tagName)")
                .foregroundStyle(.white)
                .font(.custom(FontFamily.SFPro.regular, size: 16))
                .padding(8)
                .background(Color(red: 255/255, green: 103/255, blue: 64/255))
                .cornerRadius(8)
        }
    }
}

#Preview {
    TagView("SwiftUI"){
        
    }
}
