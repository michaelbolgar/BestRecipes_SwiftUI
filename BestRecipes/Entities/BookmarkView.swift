import SwiftUI

struct BookmarkView: View {
    var body: some View {
        ZStack {
            Color.white
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                .padding(8)
            Image(.bookmarkIcone)
        }
    }
}

#Preview {
    BookmarkView()
}
