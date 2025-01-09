
import SwiftUI

struct ExpandableListView: View {
    @ObservedObject var filterItems: FilterItems
    var onItemTapped: (String) -> Void

    var body: some View {
        ScrollView(.vertical) {
            HStack {
                VStack(alignment: .leading, spacing: 0, content: {
                    ExpandableButtonView(filterItems: _filterItems, label: "Genre", expandableButtonViewitems: ["Campfire", "Beatch", "SummerKiss", "Hogokan", "Bacuman", "Pikachu"], onItemTapped: onItemTapped)
                    ExpandableButtonView(filterItems: _filterItems, label: "Another", expandableButtonViewitems: ["Bibop", "Plate", "SeasonPass"], onItemTapped: onItemTapped)
                    ExpandableButtonView(filterItems: _filterItems, label: "Attak on Titan", expandableButtonViewitems: ["Tracker", "Kabuta", "Sorrow"], onItemTapped: onItemTapped)
                }).padding([.leading], 16)
                Spacer()
            }
        }
    }
}
