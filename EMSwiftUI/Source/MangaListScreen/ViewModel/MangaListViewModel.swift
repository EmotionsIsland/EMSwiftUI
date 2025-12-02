import Foundation
import Netify

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}

protocol MangaListViewModel: ObservableObject {
    var mangaModel: MangaListModel? { get }
    @MainActor func getData(refresh: Bool) async
    func mangaGridItem(at mangaData: MangaData) -> MangaGridModel
    func category(index: Int) -> String
}

final class MangaListViewModelImpl: MangaListViewModel {
    @Published var mangaModel: MangaListModel?
    private let category: [String] = ["Popular", "New", "The Best"]
    
    private let service: MangaListService
    
    init(service: MangaListService) {
        self.service = service
    }
    
    // MARK: getData
    @MainActor func getData(refresh: Bool = false) async {
        do {
            let result = try await service.getManga()
            self.mangaModel = result
        } catch {
            print(error)
        }
    }
    
    // MARK: mangaGridItem
    func mangaGridItem(at mangaData: MangaData) -> MangaGridModel {
        let entitle = mangaData.attributes.title.en
        let ruTitle = mangaData.attributes.altTitles.first { $0.ru != nil }?.ru
        let title = entitle ?? ruTitle ?? "No title"
        let image = API.coverURL(for: mangaData, .size512)
        let tag = mangaData.attributes.tags.first?.attributes.name.en ?? "No tag"
        
        return MangaGridModel(
            title: title,
            imageUrl: image,
            tags: tag
        )
    }
    
    // MARK: category
    func category(index: Int) -> String {
        return category[index]
    }
}
