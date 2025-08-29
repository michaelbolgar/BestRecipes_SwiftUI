import SwiftUI

struct FavoriteButton: View {
    var isFavorited: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(isFavorited ? .savedRecipesActive : .savedRecipesInactive)
                .padding(8)
                .background(Circle().fill(Color.white))
        }
        .buttonStyle(FavoriteButtonStyle())
        .animation(.easeInOut(duration: 0.2), value: isFavorited)
    }
}

struct FavoriteButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

#Preview {
    FavoriteButton(isFavorited: false) {
        print("Tapped")
    }
}
