
import SwiftUI

struct ExpandableButtonView: View {
    @Binding var filteredItems: [String]
    @State private var buttonExpand = false
    var label: String = ""
    @State private var expandableButtonViewItems: [String]
    let onItemTapped: (String) -> Void

    init(filteredItems: Binding<[String]>, label: String, expandableButtonViewitems: [String], onItemTapped: @escaping (String) -> Void) {
        self.label = label
        self.expandableButtonViewItems = expandableButtonViewitems
        self.onItemTapped = onItemTapped
        self._filteredItems = filteredItems
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
            FilterSectionView(items: expandableButtonViewItems, filteredItems: $filteredItems, onItemTapped: onItemTapped, rowsCount: 0)
                .padding([.bottom], 50)
        }
    }
}
