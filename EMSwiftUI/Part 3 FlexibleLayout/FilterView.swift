//
//  FilterView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

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

struct TagView: View {
    let title: String
    let isSelected: Bool
    let showPlus: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            if !showPlus {
                Image(systemName: "plus")
            }
            Text(title)
                .fixedSize()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(isSelected ? Color.orangeBase : Color.gray.opacity(0.3))
        .foregroundColor(isSelected ? .white : .black)
        .cornerRadius(8)
        .onTapGesture {
            action()
        }
    }
}

struct ActionButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(color.opacity(configuration.isPressed ? 0.7 : 1))
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

struct FlexibleLayout<TagViewContent: View>: View {
    let tags: [String]
    let content: (String) -> TagViewContent

    @State private var totalHeight: CGFloat = .zero

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width: CGFloat = 0
        var height: CGFloat = 0
        var rows: [[String]] = [[]]

        for tag in tags {
            let tagWidth = tag.size().width + 24

            if width + tagWidth > geometry.size.width {
                width = 0
                height += 40
                rows.append([])
            }

            rows[rows.count - 1].append(tag)
            width += tagWidth + 10
        }

        return VStack(alignment: .leading, spacing: 10) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { tag in
                        content(tag)
                    }
                }
            }
        }
        .background(GeometryReader { proxy -> Color in
            DispatchQueue.main.async {
                self.totalHeight = proxy.size.height
            }
            return Color.clear
        })
    }
}

extension String {
    func size(font: UIFont = .systemFont(ofSize: 17)) -> CGSize {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        return (self as NSString).size(withAttributes: attributes)
    }
}
