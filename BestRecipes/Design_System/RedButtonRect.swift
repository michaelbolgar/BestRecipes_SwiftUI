import SwiftUI

struct RedButtonRect: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.vertical, Offsets.x3)
                .padding(.horizontal, Offsets.x8)
                .background(.redPrimary50)
                .cornerRadius(Offsets.x2)
        }
    }
}
