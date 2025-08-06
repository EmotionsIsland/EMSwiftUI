import SwiftUI

struct FlexibleTagGrid: View {
    let tags: [TagDisplayItem]
    var onTap: ((TagDisplayItem) -> Void)?
    
    var body: some View {
        FlexibleView(data: tags, spacing: 10, alignment: .leading) { item in
            Text(item.isSelected ? "+ \(item.name)" : item.name)
                .font(Font.SFPro.bodyNormal)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(item.isSelected ? Color.orangeBase : Color.grayBase)
                .foregroundColor(item.isSelected ? .whiteText : .blackBase)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                    onTap?(item)
                }
        }
    }
}
