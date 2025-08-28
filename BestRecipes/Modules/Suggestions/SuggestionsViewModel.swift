import SwiftUI

final class SuggestionsViewModel: ObservableObject {

    // MARK: Properties
    private let networkingService: SuggestionsNetworkingProtocol
    @Published var error: Error? = nil

    // MARK: Init
    init(
        networkingService: SuggestionsNetworkingProtocol = SuggestionsNetworking()
    ) {
        self.networkingService = networkingService
    }

    // MARK: Methods
    @MainActor
    func getSuggestion(dish: Dish) async -> Suggestion? {
        do {
            let suggestion = try await networkingService.getSuggestionsForDish(dish: dish)
            print(suggestion)
            return suggestion
        } catch {
            self.error = error // судя по всему, плохая практика изменения свойств vm в async фукнции. Не может делать это из background потока, надо ставить @MainActor
            print(error)
            return nil
            // вернуть какой-нибудь моковый объект с дефолтной рекомендацией?
        }
    }
}
