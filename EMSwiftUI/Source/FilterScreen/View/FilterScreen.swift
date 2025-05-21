import SwiftUI
import SwiftUIFlowLayout

struct FilterScreen<VM: FilterViewModel>: View {
    @StateObject private var viewModel: VM
    @State private var didAppear = false
    @State private var dropDownGroups: Set<String> = []
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Selection")
                .font(Font.SFPro.headline3)
                .padding(.bottom, 16)
            
            SelectedFlowLayout(viewModel: viewModel)
            
            Button("Apply") {
                viewModel.applySelection()
            }
            .frame(maxWidth: .infinity, minHeight: 44)
            .font(Font.SFPro.mediumNormal)
            .foregroundStyle(.white)
            .background(.orangeBase)
            .cornerRadius(8)
            
            Button("Reset") {
                withAnimation {
                    viewModel.resetSelection()
                }
            }
            .frame(maxWidth: .infinity)
            .font(Font.SFPro.mediumNormal)
            .foregroundStyle(.black)
            .background(.clear)
            
            Divider()
                .padding(.vertical, 16)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.groupedTags.sorted(by: { $0.key < $1.key }), id: \.key) { group, tags in
                        HStack {
                            Text(group.capitalized)
                                .font(Font.SFPro.regularLarge)
                                .padding(.trailing, 8)
                            Image(systemName: dropDownGroups.contains(group) ? "chevron.up" : "chevron.down")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                if dropDownGroups.contains(group) {
                                    dropDownGroups.remove(group)
                                } else {
                                    dropDownGroups.insert(group)
                                }
                            }
                        }
                        
                        if dropDownGroups.contains(group) {
                            GroupsFlowLayout(tags: tags, viewModel: viewModel)
                        }
                    }
                }
            }
        }
        .padding()
        .task {
            if !didAppear {
                didAppear = true
                try? await viewModel.loadTags()
            }
        }
    }
}
