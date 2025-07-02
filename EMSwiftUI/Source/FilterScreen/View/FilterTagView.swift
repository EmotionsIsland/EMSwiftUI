import SwiftUI

struct FilterTagView: View {
    let tag: FilterTag
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        }label: {
            HStack(spacing: 4) {
                if isSelected {
                    Text("+")
                }
                Text(tag.name)
            }
            .padding(8)
            .foregroundColor(.whiteText)
            .background(isSelected ? .orangeBase : .grayBase)
            .font(.SFPro.bodyNormal)
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}

#if DEBUG
struct FilterTagView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 12) {
            FilterTagView(tag: FilterTag(id: "1", name: "Shoujo", group: "genre"), isSelected: true, action: {})
            FilterTagView(tag: FilterTag(id: "2", name: "Josei", group: "genre"), isSelected: false, action: {})
        }
        .padding()
        .background(Color.white)
    }
}
#endif 
