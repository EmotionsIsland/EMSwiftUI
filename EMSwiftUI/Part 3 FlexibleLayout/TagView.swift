import SwiftUI

struct TagView: View {
    let title: String
    let isSelected: Bool
    let showPlus: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            if !showPlus {
                Image(systemName: "plus")
            }
            Text(title)
                .fixedSize()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(isSelected ? Color.orangeBase : Color.gray.opacity(0.3))
        .foregroundColor(isSelected ? .white : .black)
        .cornerRadius(8)
        .onTapGesture {
            action()
        }
    }
}
