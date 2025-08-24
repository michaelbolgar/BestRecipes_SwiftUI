import SwiftUI

struct BookmarkButton: View {
    let isBookmarked: Bool
    let action: () -> Void
    @State private var isPressed: Bool = false

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

//                if isBookmarked {
//                    Image(.savedRecipesActive)
//                        .transition(.scale.combined(with: .opacity))
//                } else {
//                    Image(.savedRecipesInactive)
//                        .transition(.scale.combined(with: .opacity))
//                }
                Image(isBookmarked ? .savedRecipesActive : .savedRecipesInactive)
            }
            .scaleEffect(isPressed ? 1.2 : 1.0)
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isBookmarked)
    }
}

#Preview {
    BookmarkButton(isBookmarked: false, action: {  print("bookmark button tapped") })
}
