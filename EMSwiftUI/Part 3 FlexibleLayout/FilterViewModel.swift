import Foundation

class FilterViewModel: ObservableObject {
    @Published var mainTags: [String] = ["Completed", "Shounen", "Award Winning", "Official Colored"]
    @Published var futureTags = SectionTags.futureTags
}
