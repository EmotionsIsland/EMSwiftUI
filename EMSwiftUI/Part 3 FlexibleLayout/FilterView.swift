import SwiftUI

struct FilterView: View {
    @StateObject var viewModel = FilterViewModel()
    
    var body: some View {
        
        Text("Filters")
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.grayBase)

        ScrollView {
            VStack(alignment: .leading) {
                Text("Selection")
                TagsCloudView(viewModel: viewModel, isSection: false, tags: [])
                    .padding(.top)
            }
            .padding(.horizontal)
            
            ZStack {
                Rectangle()
                    .frame(height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal)
                    .foregroundStyle(.orangeBase)
                Text("Apply")
                    .foregroundStyle(.whiteText)
            }
            Text("Reset")
                .padding(.vertical, 4)
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal)
                .foregroundStyle(.grayBase)
            
            ForEach(viewModel.futureTags, id: \.self) { tag in
                
                    VStack {
                        HStack {
                            HStack {
                                Text(tag.title)
                                Button {
                                    if let ind = viewModel.futureTags.firstIndex(of: tag) {
                                        viewModel.futureTags[ind].showContent.toggle()
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
}


