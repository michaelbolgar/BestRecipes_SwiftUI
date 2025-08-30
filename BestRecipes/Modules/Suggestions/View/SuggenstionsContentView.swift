import SwiftUI

struct SuggestionsContentView: View {
    @StateObject private var vm: SuggestionsViewModel

    private enum Constants {
        static let animationDuration: Double = 0.8

        static let title: String = "Wine suggestions"
        static let centralButton: String = "Choose your flavor\nI’ll choose best wine"
    }

    init() {
        _vm = StateObject(wrappedValue: SuggestionsViewModel())
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: .zero) {
                modeView
            }
            .animation(
                .easeInOut(duration: Constants.animationDuration),
                value: vm.mode
            )
        }
        .navigationTitle(Constants.title)
    }

    @ViewBuilder
    private var modeView: some View {
        switch vm.mode {
        case .main:
            mainModeView
        case .suggestion:
            wineInfoView
                .transition(.move(edge: .bottom))
        }
    }

    // MARK: Helpers
    private var mainModeView: some View {
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

                /// connections between views
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

                    /// central view
                    centralLabelView
                        .frame(width: centralSize, height: centralSize)

                    /// dish buttons
                    ForEach(positions) { item in
                        DishCircleView(
                            imageName: item.dish.title,
                            size: item.size
                        ) {
                            vm.mode = .suggestion
                        }
                        .offset(x: item.offset.x, y: item.offset.y)
                    }
                }
                .frame(height: geo.size.height * 0.6)
            }
        }
    }

    private var wineInfoView: some View {
        VStack(spacing: 20) {
            Text("Здесь будет информация о вине")
                .font(.title2)
                .foregroundColor(.black)

            Button("Назад") {
                vm.mode = .main
            }
            .padding()
            .background(Color.redPrimary80)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }

    // MARK: Subviews
    private var centralLabelView: some View {
        Circle()
            .fill(Color.white)
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
    }
}

// MARK: Dish button struct
struct DishCircleView: View {
    let imageName: String?
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        Circle() /// to avoid transparence by tapping
            .fill(Color.white)
            .frame(width: size, height: size)
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: size, height: size)
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

struct DishPosition: Identifiable {
    let id = UUID()
    let dish: Dish
    let size: CGFloat
    let offset: CGPoint
}

#Preview {
   TabbarBuilder()
        .environmentObject(CoreDataService())
}
