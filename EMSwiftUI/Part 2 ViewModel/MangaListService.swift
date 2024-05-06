//
//  MangaListService.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Combine

protocol MangaListServiceProtocol: AnyObject {
    var network: NetworkProtocol { get }
    
    func getManga() async throws -> MangaListModel
    
    func getRating(manga: MangaData) async throws -> Double?
    
    func getFilters() async throws -> FiltersList
}

final class MangaListService: MangaListServiceProtocol {
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getManga() async throws -> MangaListModel {
        let endpoint = Endpoint.mangaList
        let manga = try await network.getData(with: endpoint.url, MangaListModel.self)
        return manga
    }
    
    func getRating(manga: MangaData) async throws -> Double? {
        let data = try await network.getData(url: Endpoint(path: "/statistics/manga/" + manga.id).url)
        if let dataSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let statistics = dataSerialized["statistics"] as? [String: Any],
           let mangaIdStats = statistics[manga.id] as? [String: Any],
           let rating = mangaIdStats["rating"] as? [String: Any],
           let average = rating["average"] as? Double {
            return average
        } else {
            return nil
        }
    }
    
    func getFilters() async throws -> FiltersList {
        let endpoint = Endpoint.bigMangaList
        let mangas = try await network.getData(with: endpoint.url, MangaListModel.self).data
        
        var contentRatings = Set<String>()
        var publicationStatuses = Set<String>()
        var magazineDemographics = Set<String>()
        var formats = Set<String>()
        var genres = Set<String>()
        var themes = Set<String>()
        
        for manga in mangas {
            contentRatings.insert(manga.attributes.contentRating)
            publicationStatuses.insert(manga.attributes.status)
            if let demographic = manga.attributes.publicationDemographic {
                magazineDemographics.insert(demographic)
            }
            for tag in manga.attributes.tags {
                switch tag.attributes.group {
                case "format":
                    if let format = tag.attributes.name.en {
                        formats.insert(format)
                    }
                case "genre":
                    if let genre = tag.attributes.name.en {
                        genres.insert(genre)
                    }
                case "theme":
                    if let theme = tag.attributes.name.en {
                        themes.insert(theme)
                    }
                    
                default:
                    print(tag)
                }
            }
        }
        return FiltersList(contentRatings: contentRatings,
                           publicationStatuses: publicationStatuses,
                           magazineDemographics: magazineDemographics,
                           formats: formats,
                           genres: genres,
                           themes: themes)
    }
}
