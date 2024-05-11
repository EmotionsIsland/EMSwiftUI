import Foundation

struct SectionTags: Identifiable, Hashable {
    var id = UUID()
    var showContent: Bool
    var title: String
    var tags: [String]
    var isHidden: Bool
    
    static var futureTags: [SectionTags] = [
        SectionTags(showContent: false, title: "Content Rating", tags: ["5", "4", "3", "2", "1"], isHidden: false),
        SectionTags(showContent: false, title: "Publication Status", tags: ["Complete", "Finish"], isHidden: false), 
        SectionTags(showContent: false, title: "Magazine Demographic", tags: ["Rus", "UA", "USA"], isHidden: false),
        SectionTags(showContent: false, title: "Format", tags: ["Full", "Short"], isHidden: false),
        SectionTags(showContent: false, title: "Genre", tags: ["Comedy", "Drama"], isHidden: false), 
        SectionTags(showContent: false, title: "Theme", tags: ["Theme", "The", "TH"], isHidden: false)]
}
