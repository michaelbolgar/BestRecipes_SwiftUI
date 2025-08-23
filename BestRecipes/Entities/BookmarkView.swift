import SwiftUI

struct BookmarkView: View {
    @State private var isBookmarked = false
    @State private var isPressed = false
    var action: (Bool) -> Void

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                isPressed = true
                isBookmarked.toggle()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
            action(isBookmarked)
        }) {
            ZStack {
                Color.white
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    .padding(8)

                if isBookmarked {
                    Image(.savedRecipesActive)
                        .transition(.scale.combined(with: .opacity))
                } else {
                    Image(.savedRecipesInactive)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .scaleEffect(isPressed ? 1.2 : 1.0)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    BookmarkView(action: { _ in print("bookmark button tapped") })
}
