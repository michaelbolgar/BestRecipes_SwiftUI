import SwiftUI

struct TimerView: View {
    var timer: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.backgrountRatingView)
                .opacity(0.5)
                .frame(width: 41, height: 25)
                .padding(8)
            Text(timer)
                .font(.custom(AppFont.regular, size: 12))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    TimerView(timer: "15:10")
}
