import SwiftUI

struct SectionView: View {
    let title: String
    let tags: [String]
    @Binding var selectedTags: [String]
    let isExpanded: Bool
    let toggleExpand: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Button(action: toggleExpand) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.black)
                }
                .padding()
            }

            if isExpanded {
                FlexibleLayout(tags: tags) { tag in
                    TagView(
                        title: tag,
                        isSelected: selectedTags.contains(tag),
                        showPlus: !selectedTags.contains(tag)
                    ) {
                        if !selectedTags.contains(tag) {
                            selectedTags.append(tag)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
    }
}
