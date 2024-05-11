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
            
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 44)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.horizontal)
                            .foregroundStyle(.orangeBase)
                        Text("Apply")
                            .foregroundStyle(.whiteText)
                }
            }
            Button {
                viewModel.mainTags.removeAll()
            } label: {
                VStack {
                    Text("Reset")
                        .padding(.vertical, 4)
                    Rectangle()
                        .frame(height: 1)
                        .padding(.horizontal)
                        .foregroundStyle(.grayBase)
                }
            }
                TagCell(viewModel: viewModel)
        }
    }
}


