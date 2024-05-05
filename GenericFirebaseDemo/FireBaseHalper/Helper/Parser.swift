//
//  Parser.swift
//  GenericFirebaseDemo
//
//  Created by Nexios Mac 4 on 08/04/24.
//

import Foundation

public struct Parser {
    static func parse<T: Decodable>(_ documentData: Dictionary) throws -> T {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: documentData, options: [])
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: jsonData)
        } catch {
            throw FireBaseError.parseError
        }
    }
    
    static func parse<T: Decodable>(_ documentData: Any) throws -> T {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: documentData)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: jsonData)
        } catch {
            throw FireBaseError.parseError
        }
    }
}
