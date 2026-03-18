import SwiftUI

struct TagItemView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if isSelected {
                    ZStack {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color("whiteText"))
                    }
                }
                Text(title)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(isSelected ? .white : .black)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(isSelected ? Color("orangeBase") : Color("grayBase"))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
