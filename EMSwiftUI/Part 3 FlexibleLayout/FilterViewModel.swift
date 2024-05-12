import Foundation

class FilterViewModel: ObservableObject {
    @Published var mainTags: [String] = ["Completed", "Shounen", "Award Winning", "Official Colored"]
    @Published var allTags = [
        SectionTags(showContent: false, title: "Content Rating", tags: ["5", "4", "3", "2", "1"]),
        SectionTags(showContent: false, title: "Publication Status", tags: ["Complete", "Filming is underway"]),
        SectionTags(showContent: false, title: "Magazine Demographic", tags: ["Rus", "UA", "USA"]),
        SectionTags(showContent: false, title: "Format", tags: ["Full", "Short", "Medium"]),
        SectionTags(showContent: false, title: "Genre", tags: ["Comedy", "Drama"]),
        SectionTags(showContent: false, title: "Theme", tags: ["Love", "Friendship", "War"])]
}
