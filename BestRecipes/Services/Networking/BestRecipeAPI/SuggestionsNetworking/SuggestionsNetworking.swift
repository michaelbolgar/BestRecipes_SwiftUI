import Foundation

protocol SuggestionsNetworkingProtocol {
    func getSuggestionsForDish(dish: Dish) async throws -> Suggestion
}

final class SuggestionsNetworking: SuggestionsNetworkingProtocol {
    
    private let networkingService: NetworkingService

    init(networkingService: NetworkingService = NetworkingService()) {
        self.networkingService = networkingService
    }

    /// getting suggestion for the picked dish
    func getSuggestionsForDish(dish: Dish) async throws -> Suggestion {
        let endpoint = Endpoint.getWineSuggestion(food: dish.rawValue)
        print(endpoint)
        let response: Suggestion = try await networkingService.fetch(from: endpoint)
        return response
    }
}
