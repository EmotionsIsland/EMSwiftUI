import SwiftUI

struct TagsViewItem: View {
    let title: String
    let isSelected: Bool
        
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                if isSelected { Image(systemName: "plus") }
                Text(title)
                    .font(Font.SFPro.bodyNormal)
            }
            .foregroundStyle(Color.whiteText)
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundStyle(isSelected ? Color.orangeBase : Color.grayBase)
            )
        }
    }
}

#Preview {
    VStack {
        TagsViewItem(title: "Children", isSelected: true)
        TagsViewItem(title: "Children", isSelected: false)
    }
}
  
