
import SwiftUI

struct ExpandableButtonView: View {
    @ObservedObject var filterItems: FilterItems
    @State private var buttonExpand = false
    var label: String = ""
    @State private var expandableButtonViewItems: [String]
    let onItemTapped: (String) -> Void

    init(filterItems: ObservedObject<FilterItems>, label: String, expandableButtonViewitems: [String], onItemTapped: @escaping (String) -> Void) {
        self.label = label
        self.expandableButtonViewItems = expandableButtonViewitems
        self.onItemTapped = onItemTapped
        self._filterItems = filterItems
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Button(action: {
                buttonExpand.toggle()
            }, label: {
                HStack {
                    Label(
                        title: {
                            Text(label)
                                .font(.system(size: 20))
                                .foregroundStyle(Color.black)
                        },
                        icon: {}
                    )
                    .labelStyle(.titleOnly)
                    Label(
                        title: {},
                        icon: {
                            Image(systemName: buttonExpand ? "chevron.down" : "chevron.right")
                                .foregroundStyle(Color.black)
                        }
                    )
                    .labelStyle(.iconOnly)
                }
            })
        })

        if buttonExpand {
            FilterSectionView(items: expandableButtonViewItems, filterItems: filterItems, onItemTapped: onItemTapped, rowsCount: 0)
                .padding([.bottom], 50)
        }
    }
}
