import SwiftUI

struct MangaCoverImage: View {
    let coverURL: URL?

    var body: some View {
        Group {
            if let coverURL = coverURL {
                AsyncImage(url: coverURL) { image in
                    image
                        .resizedToFill(width: 100, height: 144)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.2))
                        ProgressView()
                            .progressViewStyle(.circular)
                            .foregroundStyle(.secondary)
                    }
                    .frame(width: 100, height: 144)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }
        }
    }
}

#Preview {
    MangaCoverImage(
        coverURL: URL(string: "https://mangadex.org/covers/f81e3b25-b2b1-4fa0-a3da-9f017b4325dc/a077ac5d-60ca-4355-8344-38a571eccdb0.jpg")
    )
}
