
import SwiftUI
import Combine

struct FilterSectionView: View {
    var items: [String]
    @ObservedObject var model: FilterModel
    var onItemTapped: (String) -> Void
    @State var rowsCount: Int = 0


    var body: some View {
        GeometryReader { geometry in
            let containerWidth = geometry.size.width

            generateDynamicGrid(containerWidth: containerWidth)
        }
        .padding(.top, 8)
        .padding(.leading, 16)
        .padding(.bottom, CGFloat(rowsCount) * 36)
    }

    func generateDynamicGrid(containerWidth: CGFloat) -> some View {
        var currentRowWidth: CGFloat = 0
        var rows: [[String]] = [[]]
        for item in items {
            let itemWidth = calculateItemWidth(text: item, font: UIFont.systemFont(ofSize: 16)) + 54

            if currentRowWidth + itemWidth > containerWidth {
                rows.append([item])
                currentRowWidth = itemWidth
            } else {
                rows[rows.count - 1].append(item)
                currentRowWidth += itemWidth
            }
        }

        return VStack(alignment: .leading, spacing: 8) {
            ForEach(0..<rows.count, id: \.self) { rowIndex in
                HStack(spacing: 8) {
                    ForEach(rows[rowIndex], id: \.self) { item in
                        Button(action: {
                            onItemTapped(item)
                            print("🍎", #function, "Tap \(item)")
                            print("🍎", #function, items)
                        }, label: {
                            if model.items.contains(item) {
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
}

func calculateItemWidth(text: String, font: UIFont) -> CGFloat {
    let label = UILabel()
    label.text = text
    label.font = font
    label.sizeToFit()
    return label.frame.width
}


//#Preview {
//    FilterSectionView(items: <#Binding<[String]?>#>)
//}
