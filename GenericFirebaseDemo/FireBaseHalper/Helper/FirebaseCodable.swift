//
//  FirestoreCodable.swift
//  GenericFirebaseDemo
//
//  Created by Nexios Mac 4 on 08/04/24.
//

import Foundation

public protocol FirebaseCodable: Hashable, Codable, Identifiable {
    var id: String { get set }
}

public typealias Dictionary = [String: Any]

extension Encodable {
    func asDictionary() -> Dictionary {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary else {
            return [:]
        }
        return dictionary
    }
}
