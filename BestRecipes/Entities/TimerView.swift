import SwiftUI

struct TimerView: View {
    var timer: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(uiColor: AppColor.backgrountRatingView))
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
