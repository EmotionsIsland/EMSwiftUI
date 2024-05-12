import SwiftUI

struct TagCell: View {
    @ObservedObject var viewModel: FilterViewModel
    
    var body: some View {
        ForEach(viewModel.allTags, id: \.self) { tag in
            VStack {
                HStack {
                    HStack {
                        Text(tag.title)
                        Button {
                            if let ind = viewModel.allTags.firstIndex(of: tag) {
                                viewModel.allTags[ind].showContent.toggle()
                            }
                        } label: {
                            Image(systemName: tag.showContent ? "chevron.up" : "chevron.down")
                                .tint(.blackBase)
                        }
                    }
                    .padding()
                    Spacer()
                }
                if tag.showContent {
                    VStack(alignment: .leading) {
                        TagsCloudView(viewModel: viewModel, isSection: true, tags: tag.tags)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
