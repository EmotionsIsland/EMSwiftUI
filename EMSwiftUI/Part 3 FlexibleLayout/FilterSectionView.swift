
import SwiftUI

struct FilterSectionView: View {
    var items: [String]
    @Binding var filteredItems: [String]
    let onItemTapped: (String) -> Void
    @State var rowsCount: Int = 0
    @State private var itemWidths: [String: CGFloat] = [:]

    var body: some View {
        GeometryReader { geometry in
            let containerWidth = geometry.size.width
            let rows = generateRowsForDynamicGrid(containerWidth: containerWidth)
            generateDynamicGrid(rows: rows)
        }
        .padding(.top, 8)
        .padding(.leading, 16)
        .padding(.bottom, CGFloat(rowsCount) * 36)
        .onAppear {
            calculateItemWidths()
        }
    }

    private func generateRowsForDynamicGrid(containerWidth: CGFloat) -> [[String]] {
        var currentRowWidth: CGFloat = 0
        var rows: [[String]] = [[]]
        for item in items {
            let itemWidth = (itemWidths[item] ?? 50) + 54

            if currentRowWidth + itemWidth > containerWidth {
                rows.append([item])
                currentRowWidth = itemWidth
            } else {
                rows[rows.count - 1].append(item)
                currentRowWidth += itemWidth
            }
        }
        return rows
    }

    private func generateDynamicGrid(rows: [[String]]) -> some View {
        return VStack(alignment: .leading, spacing: 8) {
            ForEach(0..<rows.count, id: \.self) { rowIndex in
                HStack(spacing: 8) {
                    ForEach(rows[rowIndex], id: \.self) { item in
                        Button(action: {
                            onItemTapped(item)
                        }, label: {
                            if filteredItems.contains(item) {
                                Label(item, systemImage: "plus").labelStyle(.titleAndIcon)
                                    .padding(8)
                                    .scaledToFill()
                                    .background(Color.red.opacity(0.9))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            } else {
                                Label(item, systemImage: "plus").labelStyle(.titleOnly)
                                    .padding(8)
                                    .scaledToFill()
                                    .background(Color.gray.opacity(0.9))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        })
                    }
                }
            }
        }.onAppear {
            rowsCount += rows.count
        }
    }

    private func calculateItemWidths() {
        for item in items {
            let text = Text(item).font(.system(size: 16))
            let hostingController = UIHostingController(rootView: text)
            let width = hostingController.view.intrinsicContentSize.width
            itemWidths[item] = width
        }
    }
}
