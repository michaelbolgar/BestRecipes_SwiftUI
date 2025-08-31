//
//  DictionaryTransformer.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 24.08.2025.
//

import Foundation

@objc(DictionaryTransformer)
final class DictionaryTransformer: NSSecureUnarchiveFromDataTransformer {
    override static var allowedTopLevelClasses: [AnyClass] {
        [NSDictionary.self, NSString.self]
    }

    override class func transformedValueClass() -> AnyClass {
        NSDictionary.self
    }
}
