import SwiftUI

struct SuggestionsContentView: View {

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    Color.white.ignoresSafeArea()
                    Spacer()

                    ZStack {
                        let centralSize = geo.size.width * 0.5
                        let smallSize = geo.size.width * 0.25
                        let mediumSize = geo.size.width * 0.33

                        /// central button
                        Circle()
                            .fill(Color.white)
                            .frame(width: centralSize, height: centralSize)
                            .overlay(
                                Circle()
                                    .stroke(Color.redPrimary80, lineWidth: 5)
                                )
                            .overlay(
                                Text("Choose your flavor\nI’ll choose best wine")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )

                        /// buttons above
                        /// left
                        DishCircleView(imageName: Constants.pasta, size: mediumSize, action: {} )
                            .offset(x: -centralSize * 0.6, y: -centralSize * 0.8)
                        /// right
                        DishCircleView(imageName: Constants.steak, size: mediumSize, action: {} )
                            .offset(x: centralSize * 0.5, y: -centralSize * 1.2)

                        /// buttons below
                        /// left
                        DishCircleView(imageName: Constants.cheese, size: smallSize, action: {} )
                            .offset(x: -centralSize * 0.6, y: centralSize * 0.85)

                        /// central
                        DishCircleView(imageName: Constants.shrimp, size: smallSize, action: {} )
                            .offset(x: -centralSize * 0.3, y: centralSize * 1.4)

                        /// right
                        DishCircleView(imageName: Constants.salmon, size: mediumSize, action: {} )
                            .offset(x: centralSize * 0.5, y: centralSize * 1.0)
                    }
                    .frame(height: geo.size.height * 0.6)
                }
            }
            .navigationTitle(Constants.title)
        }
    }
}

struct DishCircleView: View {
    let imageName: String?
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: size, height: size)
                    .overlay(
                        Circle()
                            .stroke(Color.redPrimary80, lineWidth: 3))
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size * 0.99, height: size * 0.99)
                        .clipShape(Circle())
                }
            }
            .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Extension
extension SuggestionsContentView {
    enum Constants {
        static let title: String = "Wine suggestions"

        static let salmon = "salmon"
        static let steak = "steak"
        static let pasta = "pasta"
        static let cheese = "cheese2"
        static let shrimp = "shrimp"
    }
}

struct CircleMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsContentView()
    }
}
