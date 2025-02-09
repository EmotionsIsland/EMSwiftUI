import SwiftUI

struct FlexibleLayout<TagViewContent: View>: View {
    let tags: [String]
    let content: (String) -> TagViewContent

    @State private var totalHeight: CGFloat = .zero

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width: CGFloat = 0
        var height: CGFloat = 0
        var rows: [[String]] = [[]]

        for tag in tags {
            let tagWidth = tag.size().width + 24

            if width + tagWidth > geometry.size.width {
                width = 0
                height += 40
                rows.append([])
            }

            rows[rows.count - 1].append(tag)
            width += tagWidth + 10
        }

        return VStack(alignment: .leading, spacing: 10) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { tag in
                        content(tag)
                    }
                }
            }
        }
        .background(GeometryReader { proxy -> Color in
            DispatchQueue.main.async {
                self.totalHeight = proxy.size.height
            }
            return Color.clear
        })
    }
}
