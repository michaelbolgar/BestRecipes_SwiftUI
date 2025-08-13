import SwiftUI

struct RatingView: View {
    var rating: Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.backgrountRatingView)
                .opacity(0.5)
                .frame(width: 58, height: 27)
                .padding(8)
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
    }
}

#Preview {
    RatingView(rating: 5.0)
}
