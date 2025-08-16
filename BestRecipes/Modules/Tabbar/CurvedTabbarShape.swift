import SwiftUI

struct CurvedTabbarShape: Shape {
    let curveRadius: CGFloat = 44
    let curveWidth: CGFloat = 125

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        let curveStartX = rect.midX - curveWidth / 2
        path.addLine(to: CGPoint(x: curveStartX, y: rect.minY))

        let controlPoint1 = CGPoint(x: rect.midX - curveWidth / 4, y: rect.minY)
        let controlPoint2 = CGPoint(x: rect.midX - curveWidth / 4, y: rect.minY + curveRadius)
        let curveBottom = CGPoint(x: rect.midX, y: rect.minY + curveRadius)

        path.addCurve(to: curveBottom, control1: controlPoint1, control2: controlPoint2)

        let controlPoint3 = CGPoint(x: rect.midX + curveWidth / 4, y: rect.minY + curveRadius)
        let controlPoint4 = CGPoint(x: rect.midX + curveWidth / 4, y: rect.minY)
        let curveEnd = CGPoint(x: rect.midX + curveWidth / 2, y: rect.minY)

        path.addCurve(to: curveEnd, control1: controlPoint3, control2: controlPoint4)

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        path.closeSubpath()

        return path
    }
}

#Preview {
    TabbarView(selectedTab: .constant(.home))
}
