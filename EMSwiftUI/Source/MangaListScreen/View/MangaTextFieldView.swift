//
//  MangaTextFieldView.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/14/25.
//

import SwiftUI

struct MangaTextFieldView: View {
    @State var text = ""
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: 358, height: 36)
            .foregroundStyle(Color(red: 237/255, green: 238/255, blue: 242/255))
            .overlay {
                TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        HStack {
                            HStack(spacing: 7) {
                                Image("search")
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(Color(red: 196/255, green: 196/255, blue: 196/255))
                                Text("Search")
                                    .foregroundStyle(Color(red: 196/255, green: 196/255, blue: 196/255))
                                    .font(.custom("SFProDisplay-Light", size: 14))
                            }
                            .padding(.leading, 7)
                            Spacer()
                        }
                    }
            }
    }
}

#Preview {
    MangaTextFieldView()
}
