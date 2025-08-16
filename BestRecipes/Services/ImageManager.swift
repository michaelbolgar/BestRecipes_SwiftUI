import SwiftUI

final class ImageManager {

    /// Creating tabbar icons
    func activeTab(name: Tab) -> Image {
        Image(name.activeTab)
    }

    func inactiveTab(name: Tab) -> Image {
        Image(name.inactiveTab)
    }
}
