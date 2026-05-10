import SwiftUI

struct FilterSectionView: View {
    let title: String
    let isExpanded: Bool
    let onHeaderTap: () -> Void
    let content: () -> AnyView
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: onHeaderTap) {
                HStack {
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .semibold))
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                content()
            }
        }
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
