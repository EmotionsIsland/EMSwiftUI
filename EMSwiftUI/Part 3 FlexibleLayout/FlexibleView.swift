import SwiftUI

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
  
    let data: Data
    let spacing: CGFloat
    
    let content: (Data.Element) -> Content
    
    @State private var availableWidth: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }
            
            FlexibleGridView(
                availableWidth: availableWidth,
                data: data,
                spacing: spacing,
                content: content
            )
        }
    }
}

