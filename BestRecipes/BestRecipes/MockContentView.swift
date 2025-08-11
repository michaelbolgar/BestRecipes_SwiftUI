import SwiftUI

struct MockContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .font(.custom(AppFont.semibold, size: 16))

            RedButtonRect(title: "Get Started") {
                print("tap")
            }
        }
        .padding()
    }
}

#Preview {
    MockContentView()
}
