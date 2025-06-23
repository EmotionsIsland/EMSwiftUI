import SwiftUI

struct FilterListScreenHeader: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Text("Filters")
                .font(.custom("SF-Pro-Text-Bold.otf", size: 24))
                .foregroundColor(.black)
            
            HStack {
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                },
                       label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(.black)
                })
            }
        }
        .background(Color.white)
    }
}
