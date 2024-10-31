
import SwiftUI

struct ExpandableListView: View {
    @ObservedObject var model: FilterModel
    var onItemTapped: (String) -> Void

    var body: some View {
        ScrollView(.vertical) {
            HStack {
                VStack(alignment: .leading, spacing: 0, content: {
                    ExpandableButtonView(model: _model, label: "Genre", expandableButtonViewitems: ["Campfire", "Beatch", "SummerKiss", "Hogokan", "Bacuman", "Pikachu"], onItemTapped: onItemTapped)
                    ExpandableButtonView(model: _model, label: "Another", expandableButtonViewitems: ["Bibop", "Plate", "SeasonPass"], onItemTapped: onItemTapped)
                    ExpandableButtonView(model: _model, label: "Attak on Titan", expandableButtonViewitems: ["Tracker", "Kabuta", "Sorrow"], onItemTapped: onItemTapped)
                }).padding([.leading], 16)
                Spacer()
            }
        }
    }
}

//#Preview {
//    ExpandableListView { _ in
//
//    }
//}
