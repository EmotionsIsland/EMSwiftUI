import SwiftUI

struct MangaSectionTitleView: View {
    @Environment(\.mangaListSection) var section
    
    var body: some View {
        HStack {
            Text(section?.title ?? "n/a")
                .font(Font.SFPro.headline3)
                .foregroundStyle(.blackBase)
            
            Spacer()
            
            HStack {
                Text("more")
                    .font(.SFPro.bodyNormal)

                Image(.moreIcon)
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            }
            .foregroundStyle(.grayBase)
        }
    }
}
