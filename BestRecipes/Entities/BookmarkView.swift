import SwiftUI

struct BookmarkView: View {
    var action: () -> Void
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                isPressed = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
            action()
        }) {
            ZStack {
                Color.white
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    .padding(8)
                Image(.bookmarkIcone)
            }
            .scaleEffect(isPressed ? 1.2 : 1.0)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    BookmarkView(action: { print("bookmark button tapped") })
}
