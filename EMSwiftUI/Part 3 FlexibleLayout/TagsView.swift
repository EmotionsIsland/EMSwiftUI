//
import SwiftUI

// Ужасная реализация, но пока только так :)
struct TagsView: View {
    @Binding var selectedTags: [String]
    
    @State var tagsGroup: [[String]] = []
    
    let allTags: [String]?

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(createTagsGroup(tags: allTags == nil ? selectedTags : allTags!), id: \.self) { group in
                HStack {
                    ForEach(group, id: \.self) { tag in
                        tagView(text: tag, isContains: selectedTags.contains(tag))
                            .onTapGesture {
                                if selectedTags.contains(tag) {
                                    guard let index = selectedTags.firstIndex(of: tag) else { return }
                                    
                                    selectedTags.remove(at: index)
                                } else {
                                    selectedTags.append(tag)
                                }
                            }
                    }
                }
            }
        }
    }
    
    func createTagsGroup(tags: [String]) -> [[String]] {
        var returnedTagsGroup: [[String]] = []
        var tempGroup: [String] = []
        var wordsWidth: CGFloat = 0
        
        let screenWidth = UIScreen.main.bounds.width

        for tag in tags {
            let label = UILabel()
            label.text = tag
            label.sizeToFit()
            
            let labelWidth = label.frame.size.width + 50
            
            if (wordsWidth + labelWidth + 20) > screenWidth {
                wordsWidth = labelWidth
                returnedTagsGroup.append(tempGroup)
                tempGroup.removeAll()
                tempGroup.append(tag)
            } else {
                wordsWidth += labelWidth
                tempGroup.append(tag)
            }
        }
        
        returnedTagsGroup.append(tempGroup)
        
        return returnedTagsGroup
    }
    
    func removeTag(tag: String) {
        selectedTags.remove(at: getIndex(value: tag))
    }
    
    func getIndex(value: String) -> Int {
        selectedTags.firstIndex(of: value) ?? 0
    }
}

private extension TagsView {
    func tagView(text: String, isContains: Bool) -> some View {
        HStack {
            if isContains {
                Image(systemName: "plus")
            }
            
            Text(text)
        }
        .padding(8)
        .background(isContains ? .orange : .gray, in: .rect(cornerRadius: 8))
    }
    
}
