import SwiftUI

struct ContryRoundCell: View {
    
    // MARK: - Properties
    let image: URL
    let title: String
    
    enum Drawing {
        static let roundSize: CGFloat = 110
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: Offsets.x2) {
            AsyncImage(url: image) { phase in
                switch phase {
                case .empty:
                    ShimmerCircle(size: Drawing.roundSize)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: Drawing.roundSize, height: Drawing.roundSize)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                case .failure:
                    AppImages.mockImage
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: Drawing.roundSize,
                            height: Drawing.roundSize
                        )
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(title)
                .recipesTitleStyle()
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }
}

#Preview {
    ContryRoundCell(image: URL(string: "https://upload.wikimedia.org/wikipedia/en/a/a4/Flag_of_the_United_States.svg")!, title: "USA")
        .padding()
}
