

import SwiftUI

struct СuisineByCountriesSection: View {
    // MARK: - Properties
    let сuisine: [Cuisine]
    var showSeeAll: (Cuisine) -> Void
    
    enum Drawing {
        static let roundSize: CGFloat = 130
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if сuisine.isEmpty  {
                HStack(spacing: Offsets.x4) {
                    ForEach(1..<6) { _ in
                        ShimmerCircle(size: Drawing.roundSize)
                    }
                }
            } else {
                HStack {
                    ForEach(сuisine) { сuisine in
                        СuisineByCountryCell(
                            image: сuisine.imageName,
                            title: сuisine.displayName
                        )
                        .padding(.vertical, Offsets.x2)
                        .onTapGesture {
                            showSeeAll(сuisine)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    СuisineByCountriesSection(сuisine: [], showSeeAll: {_ in})
}
