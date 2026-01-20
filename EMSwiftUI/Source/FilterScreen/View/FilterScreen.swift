import SwiftUI

struct FilterScreen<VM: FilterScreenViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
   private let columns = [
        GridItem(.flexible(minimum: 80))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            FilterScreenTitleView(
                title: viewModel.navigationTitle,
                dismiss: {
                })
            ScrollView {
                LazyVGrid(columns: columns,
                          alignment: .leading) {
                    ForEach(viewModel.category, id: \.self) { category in
                        Group {
                            if category == "Selection" {
                                FilterSelectionView(model: viewModel.filterSelectionModel)
                            } else {
                                FilterSectionView(model: viewModel.filterSectionModel(at: category), viewModel: viewModel)
                            }
                        }
                        .padding(16)
                    }
                }
                .padding(.top, 16)
            }
        }
        .task {
            if !viewModel.hasFetchedTags {
                await viewModel.getTags()
            }
        }
    }
}
