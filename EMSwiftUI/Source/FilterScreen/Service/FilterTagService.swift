import Foundation
import Netify

protocol FilterTagServiceProtocol {
    func fetchTags() async throws -> [FilterTag]
}

final class FilterTagService: FilterTagServiceProtocol {
    func fetchTags() async throws -> [FilterTag] {
        let url = API.mangaTags.url
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(FilterTagAPIResponse.self, from: data)
        return decoded.data.compactMap { item in
            guard let name = item.attributes.name["en"] else { return nil }
            return FilterTag(id: item.id, name: name, group: item.attributes.group)
        }
    }
} 
