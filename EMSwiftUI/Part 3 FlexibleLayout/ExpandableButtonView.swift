
import SwiftUI

struct ExpandableButtonView: View {
    @ObservedObject var model: FilterModel
    @State var buttonExpand = false
    var label: String = ""
    @State private var expandableButtonViewItems: [String]
    var onItemTapped: (String) -> Void

    init(model: ObservedObject<FilterModel>, label: String, expandableButtonViewitems: [String], onItemTapped: @escaping (String) -> Void) {
        self.label = label
        self.expandableButtonViewItems = expandableButtonViewitems
        self.onItemTapped = onItemTapped
        self._model = model
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Button(action: {
                buttonExpand.toggle()
            }, label: {
                HStack {
                    Label(
                        title: { Text(label)
                                .font(.system(size: 20))
                            .foregroundStyle(Color.black)},
                        icon: {}).labelStyle(.titleOnly)
                    Label(
                        title: {},
                        icon: {
                            Image(systemName: buttonExpand ? "chevron.down" : "chevron.right")
                                .foregroundStyle(Color.black)
                        }
                    ).labelStyle(.iconOnly)
                }
            })
        })

        if buttonExpand == true {
            FilterSectionView(items: expandableButtonViewItems, model: model, onItemTapped: onItemTapped, rowsCount: 0)
                .padding([.bottom], 20)
        }
    }
}


//#Preview {
//    ExpandableButtonView(label: "Some label", items: <#Binding<[String]>#>)
//}
