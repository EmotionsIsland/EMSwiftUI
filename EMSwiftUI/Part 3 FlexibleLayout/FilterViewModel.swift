import Foundation

class FilterViewModel: ObservableObject {
    @Published var mainTags: [String] = ["Completed", "Shounen", "Award Winning", "Official Colored"]
    //@Published var futureTags = SectionTags.futureTags
    @Published var allTags = [
        SectionTags(showContent: false, title: "Content Rating", tags: ["5", "4", "3", "2", "1"], isHidden: false),
        SectionTags(showContent: false, title: "Publication Status", tags: ["Complete", "filming is underway"], isHidden: false),
        SectionTags(showContent: false, title: "Magazine Demographic", tags: ["Rus", "UA", "USA"], isHidden: false),
        SectionTags(showContent: false, title: "Format", tags: ["Full", "Short"], isHidden: false),
        SectionTags(showContent: false, title: "Genre", tags: ["Comedy", "Drama"], isHidden: false),
        SectionTags(showContent: false, title: "Theme", tags: ["Love", "Friendship", "War"], isHidden: false)]
}
