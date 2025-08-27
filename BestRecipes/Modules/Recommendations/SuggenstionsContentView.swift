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
                        Circle()
                            .fill(Color.orange)
                            .frame(width: smallSize, height: smallSize)
                            .overlay(Text("1").foregroundColor(.white))
                            .offset(x: -centralSize * 0.6, y: -centralSize * 0.8)
                        /// right
                        Circle()
                            .fill(Color.orange)
                            .frame(width: mediumSize, height: mediumSize)
                            .overlay(Text("2").foregroundColor(.white))
                            .offset(x: centralSize * 0.5, y: -centralSize * 1.2)

                        /// buttons below
                        /// left
                        Circle()
                            .fill(Color.orange)
                            .frame(width: smallSize, height: smallSize)
                            .overlay(Text("3").foregroundColor(.white))
                            .offset(x: -centralSize * 0.6, y: centralSize * 0.85)

                        /// central
                        Circle()
                            .fill(Color.orange)
                            .frame(width: smallSize, height: smallSize)
                            .overlay(Text("4").foregroundColor(.white))
                            .offset(x: -centralSize * 0.3, y: centralSize * 1.4)

                        /// right
                        Circle()
                            .fill(Color.orange)
                            .frame(width: mediumSize, height: mediumSize)
                            .overlay(Text("5").foregroundColor(.white))
                            .offset(x: centralSize * 0.5, y: centralSize * 1.0)
                    }
                    .frame(height: geo.size.height * 0.6)

                    Spacer()
                }
            }
            .navigationTitle("Wine suggestions")
        }
    }
}

struct CircleMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsContentView()
    }
}
