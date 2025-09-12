import SwiftUI

struct SuggestionsContentView: View {
    @StateObject private var vm: SuggestionsViewModel

    // MARK: Constants
    private enum Constants {
        static let animationDuration: Double = 0.8

        static let title: String = "Wine suggestions"
        static let centralButton: String = "Choose your flavor\nI’ll choose best wine"
    }

    init() {
        _vm = StateObject(wrappedValue: SuggestionsViewModel())
    }

    // MARK: Body
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
            SuggestionView(suggestion: vm.suggestion ?? Suggestion.mockSuggestion)
                .environmentObject(vm)
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

struct SuggestionView: View {
    let suggestion: Suggestion
    @EnvironmentObject var vm: SuggestionsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                if !suggestion.pairedWines.isEmpty {
                    HStack(spacing: 12) {
                        ForEach(suggestion.pairedWines.prefix(3), id: \.self) { wine in
                            Text(wine)
                                .font(.headline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }

                Text(suggestion.pairingText)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Рекомендуемые вина")
                        .font(.headline)

                    List(suggestion.productMatches) { wine in
                        HStack(alignment: .top, spacing: 12) {
                            Image("mockImage")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 80)
                                .clipped()
                                .cornerRadius(8)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(wine.title)
                                    .font(.headline)

                                Text(wine.price)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                Text(wine.description)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .frame(height: CGFloat(suggestion.productMatches.count) * 100)
                    .listStyle(.plain)
                }
            }
            .padding()
        }
        Button(action: {
            vm.mode = .main
        }) {
            Text("Назад к выбору")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.redPrimary80)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
        }
        .padding()
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
