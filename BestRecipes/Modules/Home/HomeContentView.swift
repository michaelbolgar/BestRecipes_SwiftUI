import SwiftUI

struct HomeContentView: View {
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(AppColor.backgroundColor)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                hederView()
                    .frame(height: Offsets.x3)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        
    }
    
    private func hederView() -> some View {
        Text(Constant.hederText)
            .recipesNavTitleStyle()
            .lineLimit(2)
            .allowsTightening(true)
    }
}

extension HomeContentView {
    enum Constant {
        static let hederText: String = "Get amazing recipes for cooking"
    }
}

#Preview {
    HomeContentView()
     
}
