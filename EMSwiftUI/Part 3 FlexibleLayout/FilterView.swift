import SwiftUI

struct FilterView: View {
    @State private var selectedTags: [String] = []
    @State private var expandedSections: Set<Int> = []

    private let tagSections: [(title: String, tags: [String])] = [
        ("iOS Development", ["Swift", "UIKit", "SwiftUI", "Xcode"]),
        ("Frameworks", ["Combine", "CoreData", "Networking", "Concurrency"]),
        ("Architecture", ["MVVM", "VIPER", "MVC"]),
        ("Animations", ["Transitions", "Spring", "Keyframes"])
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if !selectedTags.isEmpty {
                VStack(alignment: .leading) {
                    Text("Selection")
                        .font(.title)
                        .padding(.bottom, 5)

                    FlexibleLayout(tags: selectedTags) { tag in
                        TagView(title: tag, isSelected: true, showPlus: false) {
                            removeTag(tag)
                        }
                    }
                }
                .padding()
            }
            
            if !selectedTags.isEmpty {
                actionButtons
            }

            ForEach(tagSections.indices, id: \.self) { index in
                SectionView(
                    title: tagSections[index].title,
                    tags: tagSections[index].tags,
                    selectedTags: $selectedTags,
                    isExpanded: expandedSections.contains(index),
                    toggleExpand: { toggleSection(index) }
                )
            }
            
            Spacer()
        }
        .padding()
    }
}

extension FilterView {
    private var actionButtons: some View {
        VStack {
            Button("Apply", action: applyFilters)
                .buttonStyle(ActionButtonStyle(color: .orangeBase))

            Button("Reset", action: resetFilters)
                .buttonStyle(.plain)
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }

    private func toggleSection(_ index: Int) {
        if expandedSections.contains(index) {
            expandedSections.remove(index)
        } else {
            expandedSections.insert(index)
        }
    }

    private func removeTag(_ tag: String) {
        selectedTags.removeAll { $0 == tag }
    }

    private func applyFilters() {
        print("Filters applied: \(selectedTags)")
    }

    private func resetFilters() {
        selectedTags.removeAll()
    }
}

extension String {
    func size(font: UIFont = .systemFont(ofSize: 17)) -> CGSize {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        return (self as NSString).size(withAttributes: attributes)
    }
}
