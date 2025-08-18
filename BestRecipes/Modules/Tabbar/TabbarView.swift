import SwiftUI

private enum TabbarConstants {
    static let tabbarHeight: CGFloat = 80
    static let iconSize: CGFloat = Offsets.x7
    static let plusButtonSize: CGFloat = Offsets.x12
    static let plusButtonOffsetY: CGFloat = Offsets.x7
}

struct TabbarView: View {

    @Binding var selectedTab: Tab

    var body: some View {
        VStack(spacing: 0) {

            ZStack {
                CurvedTabbarShape()
                    .fill(.white)
                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: -2)
                    .frame(height: TabbarConstants.tabbarHeight)
                    .frame(maxWidth: .infinity)

                HStack(spacing:  calculateSpacing()) {
                    tabbarButton(tab: .home)
                    tabbarButton(tab: .savedRecipes)
                    plusButton(tab: .plus)
                    tabbarButton(tab: .notification)
                    tabbarButton(tab: .profile)
                }
                .padding(.top, -Offsets.x3)
                .frame(maxWidth: .infinity)
            }
        }
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

    // MARK: - Creating tabbar icons
    private func fetchTabImage(tab: Tab) -> Image {
        if selectedTab == tab {
            return activeTab(name: tab)
        } else {
            return inactiveTab(name: tab)
        }
    }

    private func activeTab(name: Tab) -> Image {
        Image(name.activeTab)
    }

    private func inactiveTab(name: Tab) -> Image {
        Image(name.inactiveTab)
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

    // MARK: - Tabbar Layout
    private func calculateSpacing() -> CGFloat {
        let totalWidth = UIScreen.main.bounds.width
        let numberOfItems = 5
        let totalContentWidth = CGFloat(numberOfItems - 1) * TabbarConstants.iconSize + TabbarConstants.plusButtonSize
        let restSpace = totalWidth - totalContentWidth
        return restSpace / CGFloat(numberOfItems + 1)
    }
}

#Preview {
    AppCoordinator()
}
