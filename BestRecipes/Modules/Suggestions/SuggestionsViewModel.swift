import SwiftUI

final class SuggestionsViewModel: ObservableObject {

    enum Mode {
        case main
        case suggestion
    }

    // MARK: Properties
    @Published var mode: Mode = .main
    @Published var suggestion: Suggestion?
    @Published var error: Error? = nil
    private let networkingService: SuggestionsNetworkingProtocol

    // MARK: Init
    init(
        networkingService: SuggestionsNetworkingProtocol = SuggestionsNetworking()
    ) {
        self.networkingService = networkingService
    }

    // MARK: Methods
    @MainActor
    func getSuggestion(dish: Dish) async {
        do {
            suggestion = try await networkingService.getSuggestionsForDish(dish: dish)
        } catch {
            self.error = error // судя по всему, плохая практика изменения свойств vm в async фукнции. Не может делать это из background потока, надо ставить @MainActor
            print(error)
            // вернуть какой-нибудь моковый объект с дефолтной рекомендацией?
        }
    }
}
