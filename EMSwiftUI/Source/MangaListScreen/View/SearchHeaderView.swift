import SwiftUI

struct SearchHeaderView: View {
    @Binding var text: String
    private let placeholderOpacity = 0.5
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Image(.search)
                    .renderingMode(.template)
                    .foregroundStyle(.blackBase)
                    .opacity(placeholderOpacity)
                
                TextField(
                    "",
                    text: $text,
                    prompt: Text("Search")
                        .font(.SFPro.bodyNormal)
                        .foregroundColor(.blackBase.opacity(placeholderOpacity))
                )
                    .font(.SFPro.bodyNormal)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, minHeight: 36)
            .background(.grayBase)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.white)
    }
}
