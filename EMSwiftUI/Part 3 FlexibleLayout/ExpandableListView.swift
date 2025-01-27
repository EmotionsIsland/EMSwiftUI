
import SwiftUI

struct ExpandableListView: View {
    @Binding var filteredItems: [String]
    var onItemTapped: (String) -> Void
    private let expandableButtonViewItems: [(label: String, items: [String])] = [
        ("Genre", ["Campfire", "Beatch", "SummerKiss", "Hogokan", "Bacuman", "Pikachu"]),
        ("Another", ["Bibop", "Plate", "SeasonPass"]),
        ("Attak on Titan", ["Tracker", "Kabuta", "Sorrow"])
    ]

    var body: some View {
        ScrollView(.vertical) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(expandableButtonViewItems, id: \.label) { section in
                        ExpandableButtonView(
                            filteredItems: $filteredItems, 
                            label: section.label,
                            expandableButtonViewitems: section.items,
                            onItemTapped: onItemTapped
                        )
                    }
                }
                .padding([.leading], 16)
                Spacer()
            }
        }
    }
}
