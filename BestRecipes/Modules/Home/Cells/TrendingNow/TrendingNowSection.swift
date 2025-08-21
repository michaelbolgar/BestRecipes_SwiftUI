
import SwiftUI

struct TrendingNowSection: View {
    // MARK: - Properties
    let recipe: [RecipeModel]
    var showDetail: (Int) -> Void

    @State private var appearedIndexes: Set<Int> = []

    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if recipe.isEmpty {
                    ForEach(1..<6) { plug in
                        ShimmerView()
                            .frame(width: 300)
                            .transition(.opacity.combined(with: .scale))
                            .animation(.easeInOut(duration: 0.5).delay(Double(plug) * 0.1), value: true)
                    }
                } else {
                    ForEach(Array(recipe.enumerated()), id: \.element.id) { index, recipe in
                        TrendingNowCell(recipe: recipe)
                            .padding(.vertical, Offsets.x2)
                            .opacity(appearedIndexes.contains(index) ? 1 : 0)
                            .scaleEffect(appearedIndexes.contains(index) ? 1 : 0.95)
                            .animation(.easeOut(duration: 0.6).delay(Double(index) * 0.1), value: appearedIndexes)
                            .onAppear {
                                appearedIndexes.insert(index)
                            }
                            .onTapGesture {
                                showDetail(recipe.id)
                            }
                    }
                }
            }
        }
        .padding(.horizontal, Offsets.x2)
    }
}

#Preview {
    TrendingNowSection(recipe: [], showDetail: {_ in })
}
