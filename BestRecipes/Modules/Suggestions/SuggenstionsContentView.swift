import SwiftUI

struct SuggestionsContentView: View {

    var body: some View {
        NavigationStack {
            GeometryReader { geo in

                let centralSize = geo.size.width * 0.5
                let smallSize = geo.size.width * 0.26
                let mediumSize = geo.size.width * 0.35

                let positions: [(String, CGFloat, CGPoint)] = [
                    (Constants.pasta,  smallSize, CGPoint(x:  centralSize * 0.4, y: -centralSize * 1.3)),
                    (Constants.steak,  mediumSize, CGPoint(x: -centralSize * 0.55, y: -centralSize * 0.95)),
                    (Constants.cheese, mediumSize,  CGPoint(x: -centralSize * 0.5, y:  centralSize * 0.9)),
                    (Constants.shrimp, smallSize,  CGPoint(x:  centralSize * 0.67, y: -centralSize * 0.7)),
                    (Constants.salmon, mediumSize, CGPoint(x:  centralSize * 0.5, y:  centralSize * 1.1))
                ]

                ZStack {
                    Color.white.ignoresSafeArea()

                    ZStack {
                        ForEach(positions.indices, id: \.self) { i in
                            Path { path in
                                let start = CGPoint(x: geo.size.width / 2,
                                                    y: geo.size.height * 0.3)
                                let end = CGPoint(x: start.x + positions[i].2.x,
                                                  y: start.y + positions[i].2.y)
                                path.move(to: start)
                                path.addLine(to: end)
                            }
                            .stroke(Color.redPrimary80, lineWidth: 2)
                        }

                        /// central button
                        Circle()
                            .fill(Color.white)
                            .frame(width: centralSize, height: centralSize)
                            .overlay(
                                Circle()
                                    .stroke(Color.redPrimary80, lineWidth: 5)
                            )
                            .overlay(
                                Text(Constants.centralButton)
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                        ForEach(positions, id: \.0) { item in
                            DishCircleView(
                                imageName: item.0,
                                size: item.1
                            ) {
                                print("\(item.0) tapped")
                            }
                            .offset(x: item.2.x, y: item.2.y)
                        }
                    }
                    .frame(height: geo.size.height * 0.6)
                }
            }
            .navigationTitle(Constants.title)
        }
    }
}

// MARK: Helpers
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
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                }
            }
            .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
    }
}

struct MoleculeConnectionsView: View {
    let centralSize: CGFloat
    let buttonPositions: [CGPoint]

    var body: some View {
        ZStack {
            ForEach(buttonPositions.indices, id: \.self) { i in
                Path { path in
                    path.move(to: CGPoint(x: centralSize / 2, y: centralSize / 2))
                    path.addLine(to: CGPoint(
                        x: centralSize / 2 + buttonPositions[i].x,
                        y: centralSize / 2 + buttonPositions[i].y
                    ))
                }
                .stroke(Color.redPrimary80, lineWidth: 2)
            }
        }
        .frame(width: centralSize, height: centralSize)
    }
}

// MARK: - Extension
extension SuggestionsContentView {
    enum Constants {
        static let title: String = "Wine suggestions"

        /// buttons
        static let centralButton: String = "Choose your flavor\nI’ll choose best wine"
        static let salmon = "salmon"
        static let steak = "steak"
        static let pasta = "pasta"
        static let cheese = "cheese2"
        static let shrimp = "shrimp"
    }
}

#Preview {
   TabbarBuilder()
        .environmentObject(CoreDataService())
}
