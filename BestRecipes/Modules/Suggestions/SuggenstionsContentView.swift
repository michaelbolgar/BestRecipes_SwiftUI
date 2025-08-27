import SwiftUI

struct SuggestionsContentView: View {

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    Color.white.ignoresSafeArea()
                    Spacer()

                    ZStack {
                        let centralSize = geo.size.width * 0.5
                        let smallSize = geo.size.width * 0.25
                        let mediumSize = geo.size.width * 0.33

                        /// central button
                        Circle()
                            .fill(Color.white)
                            .frame(width: centralSize, height: centralSize)
                            .overlay(
                                Circle()
                                    .stroke(Color.redPrimary80, lineWidth: 6)
                                )
                            .overlay(
                                Text("Choose your flavor\nI’ll choose best wine")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )

                        /// buttons above
                        /// left
                        DishCircleView(imageName: "pasta", size: mediumSize)
                            .offset(x: -centralSize * 0.6, y: -centralSize * 0.8)
                        /// right
                        DishCircleView(imageName: "steak", size: mediumSize)
                            .offset(x: centralSize * 0.5, y: -centralSize * 1.2)

                        /// buttons below
                        /// left
                        DishCircleView(imageName: "cheese2", size: smallSize)
                            .offset(x: -centralSize * 0.6, y: centralSize * 0.85)

                        /// central
                        DishCircleView(imageName: "shrimp", size: smallSize)
                            .offset(x: -centralSize * 0.3, y: centralSize * 1.4)

                        /// right
                        DishCircleView(imageName: "salmon", size: mediumSize)
                            .offset(x: centralSize * 0.5, y: centralSize * 1.0)
                    }
                    .frame(height: geo.size.height * 0.6)
                }
            }
            .navigationTitle("Wine suggestions")
        }
    }
}

struct DishCircleView: View {
    let imageName: String?
    let size: CGFloat

    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .stroke(Color.redPrimary80, lineWidth: 4))
        if let imageName = imageName {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
    }
}

struct CircleMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsContentView()
    }
}
