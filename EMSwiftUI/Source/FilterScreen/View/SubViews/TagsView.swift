import SwiftUI

struct TagsView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    @State private var elementSize: [Data.Element: CGSize] = [:]
    @State private var availableWidth: CGFloat = .zero
    @State private var isInitialDrawComplete = false

    private let spacing = 4.0
    private let data: Data
    private let content: (Data.Element) -> Content

    init(data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
                .frame(minHeight: 150)
                .getSize { size in
                    if availableWidth != size.width {
                        availableWidth = size.width
                    }
                }
            
            if isInitialDrawComplete {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(computeRows(), id: \.self) { rowElements in
                        HStack(spacing: 4) {
                            ForEach(rowElements, id: \.self) { element in
                                content(element)
                                    .fixedSize()
                                    .getSize { size in
                                        if elementSize[element] != size {
                                            elementSize[element] = size
                                        }
                                    }
                            }
                        }
                    }
                }
                .transition(.opacity)
                .animation(.easeIn(duration: 0.2), value: isInitialDrawComplete)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isInitialDrawComplete = true
            }
        }
    }

    private func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth

        for element in data {
            let size = elementSize[element, default: CGSize(width: availableWidth, height: 1)]

            if remainingWidth - (size.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow += 1
                rows.append([element])
                remainingWidth = availableWidth
                remainingWidth -= (size.width + spacing)
            }

            remainingWidth -= (size.width + spacing)
        }
        return rows
    }
}

#Preview {
    TagsView(data: ["apple", "banana", "orange", "grape", "pineapple", "mango", "watermelon", "strawberry", "blueberry", "blackberry"]) { element in
        TagsViewItem(title: element, isSelected: .random())
    }
}
