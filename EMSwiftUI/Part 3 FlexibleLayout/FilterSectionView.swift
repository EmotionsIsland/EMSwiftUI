import SwiftUI

struct FilterSectionView: View {
    @State var isShowFilters = false
    @Binding var selectedFilters: [String]
    let title: String
    let allFilters: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
           sectionView()
            
            if isShowFilters {
                TagsView(selectedTags: $selectedFilters, allTags: allFilters)
            }
        }
    }
}

private extension FilterSectionView {
    func sectionView() -> some View {
        HStack {
            Text(title)
                .font(.title3)
                .bold()
            
            Spacer()
            
            Button(action: { isShowFilters.toggle() }) {
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isShowFilters ? -180 : 0))
                    .animation(.spring(), value: isShowFilters)
            }
        }
    }
}
