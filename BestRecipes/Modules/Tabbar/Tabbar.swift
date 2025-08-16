import SwiftUI

private enum TabbarConstants {
    static let tabbarHeight: CGFloat = 80
    static let iconSize: CGFloat = 24
    static let plusButtonSize: CGFloat = 48
    static let plusButtonOffsetY: CGFloat = 30
}

struct TabbarView: View {

    @Binding var selectedTab: Tab
    let imageManager = ImageManager()

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing:  calculateSpacing()) {
                tabbarButton(tab: .home)
                tabbarButton(tab: .savedRecipes)
                plusButton(tab: .plus)
                tabbarButton(tab: .notification)
                tabbarButton(tab: .profile)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: TabbarConstants.tabbarHeight)
        .frame(maxWidth: .infinity)
        .background(.white)
        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: -2)
    }

    private func tabbarButton(tab: Tab) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                fetchTabImage(tab: tab)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: TabbarConstants.iconSize, height: TabbarConstants.iconSize)
    }

    private func fetchTabImage(tab: Tab) -> Image {
        if selectedTab == tab {
            return imageManager.activeTab(name: tab)
        } else {
            return imageManager.inactiveTab(name: tab)
        }
    }

    private func plusButton(tab: Tab) -> some View {
        Button {
            withAnimation(.easeInOut) {
                print("plus tapped")
            }
        } label: {
            ZStack {
                AppImages.plusButton
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
