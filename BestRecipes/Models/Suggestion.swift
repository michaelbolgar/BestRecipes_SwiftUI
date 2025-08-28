import Foundation

/// suggestion for given dish
/// - Parameters:
    /// - pairedWines: wine names
    /// - pairingText: main idea of matching given wines to the dish
    /// - productMatches: wine objects
struct Suggestion: Decodable {
    let pairedWines: [String]?
    let pairingText: String?
    let productMatches: [Wine]?
}

struct Wine: Decodable {
    let id: Int?
    let title: String?
    let averageRating: Double?
    let description: String?
    let imageUrl: String?
    let price: String?
}
