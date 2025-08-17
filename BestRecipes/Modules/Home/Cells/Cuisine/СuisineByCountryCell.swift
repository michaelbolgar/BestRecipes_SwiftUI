import SwiftUI

struct СuisineByCountryCell: View {
    
    // MARK: - Properties
    let image: String
    let title: String
    
    enum Drawing {
        static let roundSize: CGFloat = 180
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            VStack(spacing: Offsets.x2) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: Drawing.roundSize, height: Drawing.roundSize)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                
                
                Text(title)
                    .recipesTitleStyle()
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
    }
}

#Preview {
    СuisineByCountryCell(image: "nordic", title: "USA")
        .padding()
}
