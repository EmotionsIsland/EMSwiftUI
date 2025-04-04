import SwiftUI

struct MangaListScreen<ViewModel: MangaListViewModel>: View {
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .padding(.top, 8)
                Divider()
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(MangaSection.allCases, id: \.self) { section in
                        Section {
                            MangaSectionView(viewModel: viewModel)
                        } header: {
                            NavigationLink {
                                Text("This is \(section) manga")
                            } label: {
                                MangaSectionTitleView()
                                    .padding(.horizontal, 8)
                                    .padding(.top, 4)
                            }
                        }
                        .environment(\.mangaListSection, section)
                    }
                }
                .padding(.horizontal)
                .refreshable {
                    Task { await viewModel.fetchItems() }
                }
                .alert("Network Error", isPresented: Binding<Bool>(
                    get: { viewModel.hasError },
                    set: { _ in viewModel.dismissError() }
                ), actions: {
                    Button("OK") { viewModel.dismissError() }
                }, message: {
                    Text(viewModel.errorMessage)
                })
                
                Spacer()
            }
            .hideKeyboardOnTap()
            .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    MangaListScreenBuilder.build()
}
