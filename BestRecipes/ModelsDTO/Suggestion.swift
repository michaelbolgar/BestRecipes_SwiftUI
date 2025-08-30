import Foundation

/// suggestion for given dish
/// - Parameters:
    /// - pairedWines: wine names
    /// - pairingText: main idea of matching given wines to the dish
    /// - productMatches: wine objects
struct Suggestion: Decodable {
    let pairedWines: [String]
    let pairingText: String
    let productMatches: [Wine]
}

struct Wine: Decodable, Identifiable {
    let id: Int
    let title: String
    let averageRating: Double
    let description: String
    let imageUrl: String
    let price: String
}

extension Suggestion {
    static let mockSuggestion: Suggestion =
    Suggestion(pairedWines: ["chianti","nero d avola","montepulciano"],
               pairingText: "Chianti, Nero D Avola, and Montepulciano are great choices for Parmesan. Parmesan cheese's saltiness draws out the fruitiness of those red wines while its fat content counteracts their high tannins. You could try Giacomo Mori Chianti. Reviewers quite like it with a 4.2 out of 5 star rating and a price of about 20 dollars per bottle",
               productMatches: [Wine(
                    id: 433374,
                    title: "Giacomo Mori Chianti",
                    averageRating: 4.5,
                    description: "Purple color, nose of black cherries and underbrush. Medium body, sweet and clean at first taste, should be opened after 2-3 years",
                    imageUrl: "",
                    price: "$500")]
    )
}
