import SwiftUI

struct TagsView<Data: Hashable, Content: View>: View {
    private(set) var data: [Data]
    private(set) var content: (Data) -> Content
    @State private var totalHeight: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            self.content(in: geometry)
        }
        .frame(height: totalHeight)
    }
    
    private func content(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var lastHeight = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.data, id: \.self) { item in
                self.content(item)
                    .padding(.all, 4)
                    .alignmentGuide(.leading) { dimensions in
                        if item == data.first {
                            height = .zero
                        }
                        if abs(width - dimensions.width) > geometry.size.width {
                            width = 0
                            height -= lastHeight
                        }
                        let result = width
                        if item == self.data.last {
                            width = 0 // last item
                        } else {
                            width -= dimensions.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { dimensions in
                        let result = height
                        lastHeight = dimensions.height
                        return result
                    }
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    private func viewHeightReader(_ height: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                withAnimation {
                    height.wrappedValue = geometry.frame(in: .local).size.height
                }
            }
            return .clear
        }
    }
}

#Preview {
    TagsView(
        data: [
            "apple",
            "banana",
            "orange",
            "grape",
            "pineapple",
            "mango",
            "watermelon",
            "strawberry",
            "blueberry",
            "blackberry"
        ]
    ) { element in
        TagsViewItem(title: element, isSelected: .random()) { }
    }
}
