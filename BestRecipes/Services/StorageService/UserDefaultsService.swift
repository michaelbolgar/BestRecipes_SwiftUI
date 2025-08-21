import Foundation

protocol UserDefaultsService {
    func bool(for key: Keys) -> Bool
    func set(_ value: Any?, for key: Keys)
}

final class UserDefaultsServiceImpl: UserDefaultsService {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func bool(for key: Keys) -> Bool {
        defaults.bool(forKey: key.rawValue)
    }

    func set(_ value: Any?, for key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }
}
