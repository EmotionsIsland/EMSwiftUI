import SwiftUI

struct MangaListScreen<ViewModel: MangaListViewModel>: View {
    @StateObject private var viewModel: ViewModel
    
    @State private var isFetching: Bool = true
    @FocusState var focusTF: Bool
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText, focusTF: $focusTF)
                    .padding(.top, 8)
                Divider()
                
                ZStack {
                    if isFetching {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .foregroundStyle(.secondary)
                    } else {
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
                    }
                }
                .refreshable {
                    Task { await viewModel.fetchItems() }
                }
                .alert("Nerwork Error", isPresented: $viewModel.hasError, actions: {
                    Button("OK") { viewModel.hasError = false }
                }, message: {
                    Text(viewModel.errorMessage)
                })
                
                Spacer()
            }
            .foregroundStyle(Color.white)
            .task {
                await viewModel.fetchItems()
                isFetching = false
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done Search Manga") { focusTF.toggle() }
                        .buttonStyle(.borderedProminent).tint(.orangeBase)
                }
            }
        }
    }
}

#Preview {
    MangaListScreenBuilder.build()
}
