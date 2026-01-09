import SwiftUI
import Factory

final class FilterScreenBuilder {
    static func build() -> some View {
        let service: MangaListService = MangaListServiceImpl(netify: Container.shared.netify())
        let viewModel = FilterScreenViewModelImpl(service: service)
        let view = FilterScreen(viewModel: viewModel)
        
        return view
    }
}
