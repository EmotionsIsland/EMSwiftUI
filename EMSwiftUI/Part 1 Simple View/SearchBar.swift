import SwiftUI

struct SearchBar: View {
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            Text("Seach")
                .foregroundColor(.gray)
                .padding(.leading, 10)
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding()
        .onTapGesture {
            isSearching = true
        }
    }
}
