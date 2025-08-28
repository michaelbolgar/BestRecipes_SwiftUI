import Foundation

enum Dish: String, Identifiable {
    case salmon, steak, pasta, cheese, shrimp

    var id: String { rawValue } // заглушка для конформа Identifiable
    var title: String { rawValue }
}
