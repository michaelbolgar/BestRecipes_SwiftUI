import SwiftUI

struct RatingView: View {
    var rating: Double

    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundStyle(.black)
                    .frame(width: 12, height: 12)
                Text(String(format: "%.1f", rating))
                    .font(.custom(AppFont.bold, size: 14))
                    .foregroundStyle(.white)
            }
        }
        .backgroundRatingStyle()
    }
}

#Preview {
    RatingView(rating: 5.0)
}
