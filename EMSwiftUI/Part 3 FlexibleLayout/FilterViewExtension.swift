import SwiftUI

// MARK: - Filter view extension - Disclosure View
extension FilterView {
    var DisclosureView: some View {
        HStack {
            VStack(spacing: 24) {
                DisclosureGroup("Content Rating") {
                    FlexibleView(data: viewModel.contentRating, spacing: 8) { item in
                        Button {
                            viewModel.addToSelection(item: item)
                        } label: {
                            HStack(spacing: 4) {
                                if viewModel.isTagInSelection(item: item) {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .padding(.leading, 8)
                                }
                                Text(item)
                                    .padding(8)
                                    .padding(.leading, 0)
                                    .foregroundStyle(viewModel.isTagInSelection(item: item) ? .white : .blackBase)
                            }
                            .background(viewModel.isTagInSelection(item: item) ? .orangeBase : .grayBase)
                            .cornerRadius(8)
                        }
                    }
                }
                DisclosureGroup("Publication Status") {
                    FlexibleView(data: viewModel.publicationStatus, spacing: 8) { item in
                        Button {
                            viewModel.addToSelection(item: item)
                        } label: {
                            HStack(spacing: 4) {
                                if viewModel.isTagInSelection(item: item) {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .padding(.leading, 8)
                                }
                                Text(item)
                                    .padding(8)
                                    .padding(.leading, 0)
                                    .foregroundStyle(viewModel.isTagInSelection(item: item) ? .white : .blackBase)
                            }
                            .background(viewModel.isTagInSelection(item: item) ? .orangeBase : .grayBase)
                            .cornerRadius(8)
                        }
                    }
                }
                
                DisclosureGroup("Magazine Demographic") {
                    FlexibleView(data: viewModel.magazineDemographic, spacing: 8) { item in
                        Button {
                            viewModel.addToSelection(item: item)
                        } label: {
                            HStack(spacing: 4) {
                                if viewModel.isTagInSelection(item: item) {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .padding(.leading, 8)
                                }
                                Text(item)
                                    .padding(8)
                                    .padding(.leading, 0)
                                    .foregroundStyle(viewModel.isTagInSelection(item: item) ? .white : .blackBase)
                            }
                            .background(viewModel.isTagInSelection(item: item) ? .orangeBase : .grayBase)
                            .cornerRadius(8)
                        }
                    }
                }
                
                DisclosureGroup("Format") {
                    FlexibleView(data: viewModel.magazineDemographic, spacing: 8) { item in
                        Button {
                            viewModel.addToSelection(item: item)
                        } label: {
                            HStack(spacing: 4) {
                                if viewModel.isTagInSelection(item: item) {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .padding(.leading, 8)
                                }
                                Text(item)
                                    .padding(8)
                                    .padding(.leading, 0)
                                    .foregroundStyle(viewModel.isTagInSelection(item: item) ? .white : .blackBase)
                            }
                            .background(viewModel.isTagInSelection(item: item) ? .orangeBase : .grayBase)
                            .cornerRadius(8)
                        }
                    }
                }
                
                DisclosureGroup("Genre") {
                    FlexibleView(data: viewModel.genre, spacing: 8) { item in
                        Button {
                            viewModel.addToSelection(item: item)
                        } label: {
                            HStack(spacing: 4) {
                                if viewModel.isTagInSelection(item: item) {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .padding(.leading, 8)
                                }
                                Text(item)
                                    .padding(8)
                                    .padding(.leading, 0)
                                    .foregroundStyle(viewModel.isTagInSelection(item: item) ? .white : .blackBase)
                            }
                            .background(viewModel.isTagInSelection(item: item) ? .orangeBase : .grayBase)
                            .cornerRadius(8)
                        }
                    }
                }
                
                DisclosureGroup("Theme") {
                    FlexibleView(data: viewModel.theme, spacing: 8) { item in
                        Button {
                            viewModel.addToSelection(item: item)
                        } label: {
                            HStack(spacing: 4) {
                                if viewModel.isTagInSelection(item: item) {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .padding(.leading, 8)
                                }
                                Text(item)
                                    .padding(8)
                                    .padding(.leading, 0)
                                    .foregroundStyle(viewModel.isTagInSelection(item: item) ? .white : .blackBase)
                            }
                            .background(viewModel.isTagInSelection(item: item) ? .orangeBase : .grayBase)
                            .cornerRadius(8)
                        }
                    }
                }
            }
            .foregroundStyle(.blackBase)
            .tint(.blackBase)
        }
    }
}
