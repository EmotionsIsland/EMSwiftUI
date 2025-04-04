import SwiftUI

struct TagsView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    @State private var elementSize: [Data.Element: CGSize] = [:]
    @State private var availableWidth: CGFloat = .zero
    let columns: [GridItem]
    let rows: [GridItem]
    let data: Data
    let content: (Data.Element) -> Content
    let spacing = 8.0
    
    init(data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
        rows = [GridItem(.flexible(), spacing: spacing, alignment: .leading)]
        columns = [GridItem(.flexible(), spacing: spacing, alignment: .leading)]
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Color.clear.frame(height: 1)
                .getSize { size in
                    availableWidth = size.width
                }
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: spacing) {
                ForEach(computeRows(), id: \.self) { computedRow in
                    LazyHGrid(rows: rows) {
                        ForEach(computedRow, id: \.self) { item in
                            content(item)
                                .fixedSize()
                                .getSize { size in
                                    elementSize[item] = size
                                }
                        }
                    }
                }
            }
        }
    }
}

private extension TagsView {
    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in data {
            let elementSize = elementSize[element, default: CGSize(width: availableWidth, height: 1)]
            
            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow += 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            remainingWidth -= (elementSize.width + spacing)
        }
        return rows
    }
}

private extension TagsView {
    struct ItemGroup: Hashable {
        var id = UUID()
        let item: [TagsViewItem]
    }
}

#Preview {
    TagsView(data: ["apple", "banana", "orange", "grape", "pineapple", "mango"]) { element in
        TagsViewItem(title: element, isSelected: .random())
    }
}
