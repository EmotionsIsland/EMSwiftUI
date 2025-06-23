import SwiftUI

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    @State private var availableWidth: CGFloat = 0
    @State private var layoutNeedsUpdate = false
    let data: Data
    let spacing: CGFloat
    let content: (Data.Element, @escaping () -> Void) -> Content
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                    layoutNeedsUpdate.toggle()
                }
            
            _FlexibleView(
                availableWidth: availableWidth,
                data: data,
                spacing: spacing) { element in
                    content(element) {
                        layoutNeedsUpdate.toggle()
                    }
                }
        }
        .id(layoutNeedsUpdate)
    }
}
