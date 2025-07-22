//
//  MangaListViewModel.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Netify

protocol MangaListViewModel: ObservableObject {
    var mangaList: [SingleGridMangaModel] { get }
    var sections: [SectionDataModel] { get }
    @MainActor func getData() async
    @MainActor func loadImage(_ url: URL?) async -> UIImage?
}

final class MangaListViewModelImpl: MangaListViewModel {
    private let service: MangaListService
    
    @Published private(set) var mangaList: [SingleGridMangaModel] = []
    @Published private(set) var sections: [SectionDataModel] = []

    init(service: MangaListService) {
        self.service = service
    }
    
    @MainActor func loadImage(_ url: URL?) async -> UIImage? {
        guard let url else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
    
    @MainActor func getData() async {
        do {
            mangaList = try await service.getManga().data.map {
                convert($0)
            }
            
            // Я не нашёл способа динамически раскидать объекты по секциям, поскольку не нашёл ничего подходящего в ответе от сервера. Поэтому решил хардкодить :/
            sections = [
                SectionDataModel(title: "Popular", items: Array(mangaList[0...5])),
                SectionDataModel(title: "Recently Added", items: Array(mangaList[6...11])),
                SectionDataModel(title: "Last Updates", items: Array(mangaList[12...17])),
                SectionDataModel(title: "Seasonal", items: Array(mangaList[18...23]))
            ]
        } catch {
            return
        }
    }
    
    /// Метод, который конвертирует объект типа MangaData в объект типа SingleGridMangaModel
    /// - Parameters :
    ///   - mangaObject: Объект, который будет конвертироваться
    /// - Returns: Сконвертированный объект типа SingleGridMangaModel
    private func convert(_ mangaObject: MangaData) -> SingleGridMangaModel {
        let convertedObject = SingleGridMangaModel(url: getCoverUrl(for: mangaObject.id, getFileName(of: mangaObject))!,
                                                   tags: mangaObject.attributes.tags.map { $0.attributes.name.en ?? ""},
                                                   title: mangaObject.attributes.title.en ?? "Unkown")
        
        return convertedObject
    }
    
    /// Метод, который получает имя обложки объекта MangaData. Метод был создан, поскольку каждый объект MangaData хранит имя обложки в одном из объектов массива relationships. Массив relationships не имеет фиксированного количества элементов, так что достать имя по единному индексу невозможно. Скорее всего, всё можно было сделать гораздо проще, но я не нашёл лучшего решения :p
    /// - Parameters:
    ///   - mangaObject: Объект, имя обложи которого мы получаем
    /// - Returns: имя обложки
    private func getFileName(of mangaObject: MangaData) -> String? {
        guard let index = mangaObject.relationships.firstIndex(where: { $0.type == "cover_art" }) else {
            return nil
        }
        
        return  mangaObject.relationships[index].attributes?.fileName
    }
    
    /// Метод, который строит URL обложки на основе id и имени обложки определённой манги.
    /// - Parameters:
    ///   - mangaId: ID манги.
    ///   - fileName: Имя обложки манги.
    ///   - resolution: Разрешение, по умолчанию равное 256 чтобы ускорить загрузку.
    /// - Returns: Полный URL обложки в разрешении 256.
    private func getCoverUrl(for mangaId: String, _ fileName: String?, _ resolution: SizeFormat = .size256) -> URL? {
        guard let fileName else {
            return nil
        }
        let base = "https://uploads.mangadex.org/covers"
        let thumb = fileName + resolution.rawValue
        
        return URL(string: "\(base)/\(mangaId)/\(thumb)")
    }
}

enum SizeFormat: String {
    case size256 = ".256.jpg"
    case size512 = ".512.jpg"
    case size1024 = ".1024.jpg"
}
