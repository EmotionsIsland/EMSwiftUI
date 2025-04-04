import SwiftUI

struct NavigationBar<Content: View>: View {
    var rightBarItems: (() -> Content)?
    var leftBarItems: (() -> Content)?
    let title: String
    
    init(
        _ title: String,
        rightBarItems: (() -> Content)? = nil,
        leftBarItems: (() -> Content)? = nil
    ) {
        self.title = title
        self.rightBarItems = rightBarItems
        self.leftBarItems = leftBarItems
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack(spacing: 8) {
                    rightBarItems?()
                    Spacer()
                }
                .padding(.leading, 16)
                
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(Font.SFPro.headline2)
                    .foregroundStyle(.blackBase)
                
                HStack(spacing: 8) {
                    Spacer()
                    leftBarItems?()
                }
                .padding(.trailing, 16)
            }
            Divider()
        }
    }
}

#Preview {
    NavigationBar("Filter") {
        Button {
            print("action")
        } label: {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundStyle(.blackBase)
                .frame(width: 30, height: 30)
        }
    } leftBarItems: {
        Button {
            print("action")
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundStyle(.blackBase)
                .frame(width: 30, height: 30)
        }
    }}
