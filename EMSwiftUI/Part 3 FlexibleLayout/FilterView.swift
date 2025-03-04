//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    
    @State private var selectedTags: [String] = []
    
    let contentTags = ContentTags()
    
    var body: some View {
        ScrollView{
            VStack {
                // TODO: Create View
                ZStack{
                    Text("Filters")
                        .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                        .font(.custom(FontFamily.SFPro.bold, size: 24))
                    HStack{
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.blackBase)
                        })
                    }
                }
                .padding(.horizontal, 20)
                
                Divider()
                    .padding(.bottom, 20)
                
                HStack{
                    Text("Selection")
                        .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                        .font(.custom(FontFamily.SFPro.bold, size: 20))
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                if(selectedTags.isEmpty){
                    Text("No selected tags")
                        .foregroundStyle(Color(red: 106/255, green: 106/255, blue: 106/255))
                        .font(.custom(FontFamily.SFPro.light, size: 20))
                }
                
                FlowLayout{
                    ForEach(selectedTags, id: \.self){ tag in
                        TagView(tag){
                            removeTag(tag: tag)
                        }
                        .padding(5)
                    }
                }
                .padding(.horizontal, 20)
                
                Button {
                    buttonApplyWasTapped()
                } label: {
                    Text("Apply")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 255/255, green: 103/255, blue: 64/255))
                        .foregroundStyle(.white)
                        .font(.custom(FontFamily.SFPro.medium, size: 16))
                        .cornerRadius(8)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                
                Button {
                    buttonResetWasTapped()
                } label: {
                    Text("Reset")
                        .foregroundStyle(Color(red: 56/255, green: 56/255, blue: 56/255))
                        .font(.custom(FontFamily.SFPro.medium, size: 16))
                }

                Divider()
                    .padding(.bottom, 20)
                
                ForEach(contentTags.tags){ tag in
                    FilterSection(sectionName: tag.name, tags: tag.tags){ value in
                        appendTag(tag: value)
                    }
                    .padding(.bottom, 10)
                }
                
                Spacer()
            }
        }
    }
    
    private func appendTag(tag: String){
        if(!selectedTags.contains(tag)){
            withAnimation{
                selectedTags.append(tag)
            }
        }
    }
    
    private func removeTag(tag: String){
        if let tagIndex = selectedTags.firstIndex(of: tag){
            withAnimation{
                selectedTags.remove(at: tagIndex)
            }
        }
    }
    
    private func buttonApplyWasTapped(){
        
    }
    
    private func buttonResetWasTapped(){
        withAnimation{
            selectedTags.removeAll()
        }
    }
}

#Preview {
    FilterView()
}
