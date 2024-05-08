import SwiftUI

struct MangaSectionTitleView: View {
    @Binding var title: String
    var body: some View {
        HStack(alignment: .center) {
            Text(title).fontWeight(.semibold)
            Spacer()
            HStack(alignment: .center, spacing: 8) {
                Text("more")
                Image("moreIcon")
            }
        }
    }
}
