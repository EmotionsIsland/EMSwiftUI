import SwiftUI

struct FilterScreen<VM: FilterScreenViewModel>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                
                FiltersSectionView(viewModel: viewModel)
                    .padding(16)
                    .background(Color.white)
                
                Divider()
                
                AllFiltersView(viewModel: viewModel)
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Close tapped")
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.blackBase)
                            .font(.system(size: 18, weight: .medium))
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
