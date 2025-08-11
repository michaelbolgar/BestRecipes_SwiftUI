import SwiftUI

struct RedButtonCapsule: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, Offsets.x2)
                .padding(.horizontal, Offsets.x8)
                .background(Color(AppColor.redPrimary50))
                .clipShape(Capsule())
        }
    }
}

#Preview {
    RedButtonCapsule(title: "Continue") {
        print("tap")
    }
}
