//
//  FireStoreDatabaseService.swift
//  GenericFirebaseDemo
//
//  Created by Nexios Mac 4 on 08/04/24.
//

import FirebaseFirestore

public protocol FireStoreDatabaseServiceProtocol {
    static func request<T>(for endPoint: FireStoreEndPoint) async throws -> T where T: FirebaseCodable
    static func request<T>(for endPoint: FireStoreEndPoint) async throws -> [T] where T: FirebaseCodable
    static func request(for endPoint: FireStoreEndPoint) async throws
}

public class FireStoreDatabaseService: FireStoreDatabaseServiceProtocol {
    public static func request<T>(for endPoint: FireStoreEndPoint) async throws -> T where T: FirebaseCodable {
        guard let refrance = endPoint.path as? DocumentReference else {
            throw FireBaseError.documentNotFound
        }
        switch endPoint.method {
        case .get:
            guard let documentSnapshot = try? await refrance.getDocument() else {
                throw FireBaseError.invalidPath
            }
            guard let documentData = documentSnapshot.data() else {
                throw FireBaseError.parseError
            }
            let singleResponse: T = try Parser.parse(documentData)
            return singleResponse
        default:
            throw FireBaseError.invalidRequest
        }
    }
    
    public static func request<T>(for endPoint: FireStoreEndPoint) async throws -> [T] where T: FirebaseCodable {
        guard let refrance = endPoint.path as? Query else {
            throw FireBaseError.collectionNotFound
        }
        switch endPoint.method {
        case .get:
            let querySnapshot = try await refrance.getDocuments()
            var response: [T] = []
            for document in querySnapshot.documents {
                let data: T = try Parser.parse(document.data())
                response.append(data)
            }
            return response
        default:
            throw FireBaseError.operationNotSupported
        }
    }
    
    public static func request(for endPoint: FireStoreEndPoint) async throws {
        guard let refrance = endPoint.path as? DocumentReference else {
            throw FireBaseError.documentNotFound
        }
        switch endPoint.method {
        case .get:
            throw FireBaseError.operationNotSupported
        case var .post(model):
            model.id = refrance.documentID
            try await refrance.setData(model.asDictionary())
        case let .update(model):
            try await refrance.setData(model.asDictionary())
        case .delete:
            try await refrance.delete()
        }
    }
}
