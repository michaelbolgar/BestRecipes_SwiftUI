import SwiftUI

struct SuggestionsContentView: View {
    @StateObject private var vm: SuggestionsViewModel

    //    MARK: - INIT
    init() {
        self._vm = StateObject(wrappedValue: SuggestionsViewModel())
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geo in

                let centralSize = geo.size.width * 0.5
                let smallSize = geo.size.width * 0.26
                let mediumSize = geo.size.width * 0.35

                let positions: [DishPosition] = [
                    .init(dish: .pasta,  size: smallSize, offset: CGPoint(x:  centralSize * 0.4, y: -centralSize * 1.3)),
                    .init(dish: .steak,  size: mediumSize, offset: CGPoint(x: -centralSize * 0.55, y: -centralSize * 0.95)),
                    .init(dish: .cheese, size: mediumSize,  offset: CGPoint(x: -centralSize * 0.5, y:  centralSize * 0.9)),
                    .init(dish: .shrimp, size: smallSize,  offset: CGPoint(x:  centralSize * 0.67, y: -centralSize * 0.7)),
                    .init(dish: .salmon, size: mediumSize, offset: CGPoint(x:  centralSize * 0.5, y:  centralSize * 1.1))
                ]

                ZStack {
                    Color.white.ignoresSafeArea()

                    ZStack {
                        ForEach(positions.indices, id: \.self) { i in
                            Path { path in
                                let start = CGPoint(x: geo.size.width / 2,
                                                    y: geo.size.height * 0.3)
                                let end = CGPoint(x: start.x + positions[i].offset.x,
                                                  y: start.y + positions[i].offset.y)
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
                                Text(Titles.centralButton)
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                        ForEach(positions) { item in
                            DishCircleView(
                                imageName: item.dish.title,
                                size: item.size
                            ) {
                                Task {
                                    await vm.getSuggestion(dish: item.dish)
                                }
                            }
                            .offset(x: item.offset.x, y: item.offset.y)
                        }
                    }
                    .frame(height: geo.size.height * 0.6)
                }
            }
            .navigationTitle(Titles.title)
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
//                    .overlay(
//                        Circle()
//                            .stroke(Color.redPrimary80, lineWidth: 3))
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

struct DishPosition: Identifiable {
    let id = UUID()
    let dish: Dish
    let size: CGFloat
    let offset: CGPoint
}


// MARK: - Extension
extension SuggestionsContentView {
    enum Titles {
        static let title: String = "Wine suggestions"
        static let centralButton: String = "Choose your flavor\nI’ll choose best wine"

    }
}

#Preview {
   TabbarBuilder()
        .environmentObject(CoreDataService())
}
