//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct FilterView: View {
    private let tags = [" + Completed", " + Shounen", " + Award Winning", " + Official Colored"]
    private let columns = [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)]
    
    var body: some View {
        VStack {
            Text("Filters")
            Rectangle().frame(height: 1).foregroundStyle(.grayBase)
        }
        VStack(alignment: .leading) {
            Text("Selection").padding(.top)
            TagCloudView(tags: tags)
        }.padding(.horizontal)
        ZStack {
            Rectangle()
                .frame(height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal)
                .foregroundStyle(.orangeBase)
            Text("Apply").foregroundStyle(.whiteText)
            
        }
        Text("Reset")
        Rectangle().frame(height: 1).foregroundStyle(.grayBase)
        Spacer()
    }
}
#Preview {
    FilterView()
}


struct TagCloudView: View {
    var tags: [String]

    @State private var totalHeight
    //     = CGFloat.zero       // << variant for ScrollView/List
        = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        //.frame(height: totalHeight)// << variant for ScrollView/List
        .frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.item(for: tag)
                    .padding(.trailing, 10)
                    .padding(.vertical, 6)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String) -> some View {
        Text(text)
            .padding(.all, 8)
            .background(Color.orangeBase)
            .foregroundStyle(.whiteText)
            .cornerRadius(8)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
