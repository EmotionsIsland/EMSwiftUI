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
