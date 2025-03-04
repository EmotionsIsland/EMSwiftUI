//
//  FilterSection.swift
//  EMSwiftUI
//
//  Created by Гриша Шкробов on 04.03.2025.
//

import SwiftUI

struct FilterSection: View {
    
    @State var sectionName: String
    
    @State var tags: [String]
    
    @State private var isHide: Bool = true
    
    let action: (String) -> ()
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    withAnimation {
                        isHide.toggle()
                    }
                } label: {
                    Text(sectionName)
                        .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                        .font(.custom(isHide ? FontFamily.SFPro.regular : FontFamily.SFPro.bold, size: 20))
                    Image(systemName: isHide ? "chevron.down" : "chevron.up")
                        .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            
            if(!isHide){
                FlowLayout{
                    ForEach(tags, id: \.self){ tag in
                        TagView(tag){
                            action(tag)
                        }
                        .padding(5)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    FilterSection(sectionName: "Content Rating", tags: ["Hello", "World", "I love", "Movie"]){_ in
        
    }
}
