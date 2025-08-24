//
//  API.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 12.08.2025.
//

import Foundation

enum API {
    static let apiKey = ApiKeys.ten
    static let header = "x-api-key"
}

enum HTTPMethod: String {
    case get = "GET"
}

enum ApiKeys: String {
    case firstKey = "dbe02e6c827948cab1164a95cab41203"
    case secondKey = "97534030321f4b98b1a71a171f2a5d77"
    case third = "5ae93d38d7cf4f94912465f822fa82eb"
    case fourth = "8af6d4be783d4b43b39b0462d2922c25"
    case fifth = "83f1f194da3247dea340def455587b9e"
    case six = "14bce0d6c60c40159cef29d9763aac19"
    case seven = "a1a20a4a124747d68fb8dd4f0a957e45"
    case eight = "0550a12354c74c4b92da388c778540d7"
    case nine = "f181665459eb48d9b46f7ed64fdcc92e"
    case ten = "7bacf3f7cc7e408e9949dd374a8ddad7"
    case eleven = "8cf18949852e4f6e82c12342cf83cdc9"
    case twelve = "11e930669851467ebda17458e91269a9"
    case thirteen = "977e7847d283492bb87bffe3d7256e12"
    case fourteen = "3df4748a170f45ce9c519d7371a16480"
    case fifteen = "4746f1a7e1ad4876996cd8e626b05ce4"
    case sixteen = "b6dbf7fcf5094745ac11204866483713"
    case seventeen = "f53c3c540feb41b08450248060e8cd77"
}
