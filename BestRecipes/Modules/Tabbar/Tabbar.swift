import SwiftUI

private enum TabbarConstants {
    static let tabbarHeight: CGFloat = 80
    static let iconSize: CGFloat = 24
    static let plusButtonSize: CGFloat = 48
    static let plusButtonOffsetY: CGFloat = 30
}

struct TabbarView: View {

    @Binding var selectedTab: Tab

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing:  calculateSpacing()) {
                tabbarButton(tab: .home, iconName: "house")
                tabbarButton(tab: .savedRecipes, iconName: "bookmark")
                plusButton(tab: .plus, iconName: "plusButton")
                tabbarButton(tab: .notification, iconName: "bell")
                tabbarButton(tab: .profile, iconName: "person")
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: TabbarConstants.tabbarHeight)
        .frame(maxWidth: .infinity)
        .background(.white)
        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: -2)
    }

    private func tabbarButton(tab: Tab, iconName: String) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
            .frame(width: 24)
            .foregroundStyle(selectedTab == tab ? .redPrimary80 : .neutral30)
        }
    }

    private func plusButton(tab: Tab, iconName: String) -> some View {
        Button {
            withAnimation(.easeInOut) {
                print("plus tapped")
            }
        } label: {
            ZStack {
                Image(iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: TabbarConstants.plusButtonSize, height: TabbarConstants.plusButtonSize)
            }
        }
        .offset(y: -TabbarConstants.plusButtonOffsetY)
    }

    private func calculateSpacing() -> CGFloat {
        let totalWidth = UIScreen.main.bounds.width
        let numberOfItems = 5
        let totalContentWidth = CGFloat(numberOfItems - 1) * TabbarConstants.iconSize + TabbarConstants.plusButtonSize
        let restSpace = totalWidth - totalContentWidth
        return restSpace / CGFloat(numberOfItems + 1)
    }
}

#Preview {
    TabbarView(selectedTab: .constant(.home))
}
