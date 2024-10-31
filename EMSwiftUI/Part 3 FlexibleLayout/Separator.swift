
import SwiftUI

struct Separator: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .opacity(0.3)
            .frame(height: 1)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

#Preview {
    Separator()
}
