import Foundation
import SwiftUI

struct _FlexibleView<Data: Collection, Content: View>: View
where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let content: (Data.Element) -> Content
    @State private var elementsSize: [Data.Element: CGSize] = [:]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if availableWidth > 0 {
                ForEach(computeRows(), id: \.self) { rowElements in
                    HStack {
                        ForEach(rowElements, id: \.self) { element in
                            content(element)
                                .fixedSize()
                                .readSize { size in
                                    elementsSize[element] = size
                                }
                        }
                    }
                }
            }
        }
    }
}

private extension _FlexibleView {
    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
            
            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                // start a new row
                currentRow += 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            remainingWidth -= (elementSize.width + spacing)
        }
        
        return rows
    }
}
