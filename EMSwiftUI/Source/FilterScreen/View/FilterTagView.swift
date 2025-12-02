import SwiftUI

struct FilterTagView: View {
    let tag: Tag
    let isSelected: Bool
    let action: (_ tagSelected: Tag) -> Void
    
    var body: some View {
        Button {
            action(tag)
        }label: {
            HStack(spacing: 4) {
                if isSelected {
                    Text("+")
                }
                Text(tag.attributes.name.en ?? "no title")
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
