import SwiftUI

// MARK: реализовать измененние цвета ппри нажатии кнопки
struct TagsCloudView: View {
    @ObservedObject var viewModel: FilterViewModel
    @State private var totalHeight = CGFloat.zero

    @State var isSection: Bool
    var tags: [String] = []
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            
            switch self.isSection {
            case true:
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
                        .alignmentGuide(.top, computeValue: { d in
                            let result = height
                            if tag == self.tags.last! {
                                height = 0 // last item
                            }
                            return result
                        })
                }
            default:
                ForEach(self.viewModel.mainTags, id: \.self) { tag in
                    
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
                            if tag == self.viewModel.mainTags.last! {
                                width = 0 //last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: { d in
                            let result = height
                            if tag == self.viewModel.mainTags.last! {
                                height = 0 // last item
                            }
                            return result
                        })
                }
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    @ViewBuilder private func item(for text: String) -> some View {
       
            Button {
                guard !viewModel.mainTags.contains(text) else {
                    viewModel.mainTags.remove(at: indexSearch(text: text)!)
                    return
                }
                self.viewModel.mainTags.append(text)
                
            } label: {
                HStack {
                    if !isSection {
                        Image(systemName: "plus")
                    }
                        Text(text)
                }
                .padding(.all, 8)
                .background(isSection ? Color.gray : Color.orangeBase)
                .foregroundStyle(.whiteText)
                .cornerRadius(8)
            }
        
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

extension TagsCloudView {
    
    func indexSearch(text: String) -> Int? {
        let arr = self.viewModel.mainTags
        if let index = arr.firstIndex(where: { $0 == text }) {
            return index
        }
        return nil
    }
//    func changeVisibility(id: UUID) {
//        if let index = indexSearch(id: id) {
//            self.viewModel.allTags[index].isHidden.toggle()
//        }
//    }
}
