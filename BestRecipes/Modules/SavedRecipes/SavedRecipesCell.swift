import SwiftUI

struct SavedRecipesCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Image("mockImage")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10))
                
                RatingView(rating: 5.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                TimerView(timer: "15:10")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                
                BookmarkView(action: {_ in print("button tapped")})
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            .frame(height: 180)
            
            HStack {
                Text("How to make sharwama at home")
                    .font(.custom(AppFont.bold, size: 16))
            }
            .padding(.vertical, 12)
            
            HStack {
                Image("mockImage")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                Text("By Zeelicious Foods")
                    .font(.custom(AppFont.regular, size: 12))
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    SavedRecipesCell()
}
