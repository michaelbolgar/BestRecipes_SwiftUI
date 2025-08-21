import SwiftUI

struct TimerView: View {
    var timer: String
    var body: some View {
        Text(timer)
            .font(.custom(AppFont.regular, size: 12))
            .foregroundColor(.white)
            .backgroundRatingStyle()
    }
}

#Preview {
    TimerView(timer: "15:10")
}
