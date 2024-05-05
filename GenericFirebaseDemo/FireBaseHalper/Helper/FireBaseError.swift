//
//  FirestoreServiceError.swift
//  GenericFirebaseDemo
//
//  Created by Nexios Mac 4 on 08/04/24.
//

import Foundation

public enum FireBaseError: Error {
    case invalidPath
    case invalidType
    case collectionNotFound
    case documentNotFound
    case refranceNotFound
    case unknownError
    case parseError
    case invalidRequest
    case operationNotSupported
    case invalidQuery
    case operationNotAllowed
}

extension FireBaseError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidPath:
            return "Path not found."
        case .invalidType:
            return "Invalid type."
        case .collectionNotFound:
            return "Collection not found."
        case .documentNotFound:
            return "Document not found."
        case .refranceNotFound:
            return "Refrance not found."
        case .unknownError:
            return "Unknown error."
        case .parseError:
            return "Data did not parse."
        case .invalidRequest:
            return "Request is invalid."
        case .operationNotSupported:
            return "Method did not support."
        case .invalidQuery:
            return "Query is not valid."
        case .operationNotAllowed:
            return "Operation not allowed."
        }
    }
}
