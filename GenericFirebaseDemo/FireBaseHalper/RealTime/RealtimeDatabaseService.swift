//
//  RealtimeDatabaseService.swift
//  GenericFirebaseDemo
//
//  Created by AKASH BOGHANI on 05/05/24.
//

import Firebase

public protocol RealtimeDatabaseServiceProtocol {
    static func observe<T>(for endPoint: RealtimeEndPoint, eventType: DataEventType, handler: @escaping (Result<T, Error>) -> Void)
    static func request<T>(for endPoint: RealtimeEndPoint) async throws -> T where T: FirebaseCodable
    static func request<T>(for endPoint: RealtimeEndPoint) async throws -> [T] where T: FirebaseCodable
    static func request(for endPoint: RealtimeEndPoint) async throws
}

public class RealtimeDatabaseService: RealtimeDatabaseServiceProtocol {
    public static func observe<T>(for endPoint: any RealtimeEndPoint, eventType: DataEventType, handler: @escaping (Result<T, any Error>) -> Void) {
        guard let reference = endPoint.path as? DatabaseQuery else {
            handler(.failure(FireBaseError.invalidPath))
            return
        }
        switch endPoint.method {
        case .get:
            reference.observe(eventType) { snapshot in
                guard let value = snapshot.value as? T else { 
                    handler(.failure(FireBaseError.invalidType))
                    return
                }
                handler(.success(value))
            }
        default:
            handler(.failure(FireBaseError.invalidRequest))
        }
    }

    public static func request<T>(for endPoint: any RealtimeEndPoint) async throws -> T where T : FirebaseCodable {
        guard let reference = endPoint.path as? DatabaseQuery else {
            throw FireBaseError.invalidPath
        }
        switch endPoint.method {
        case .get:
            guard let snapshot = try await reference.getData().value as? Dictionary else {
                throw FireBaseError.invalidRequest
            }
            let singleResponse: T = try Parser.parse(snapshot)
            return singleResponse
        default:
            throw FireBaseError.invalidRequest
        }
    }
    
    public static func request<T>(for endPoint: any RealtimeEndPoint) async throws -> [T] where T : FirebaseCodable {
        guard let reference = endPoint.path as? DatabaseQuery else {
            throw FireBaseError.invalidPath
        }
        switch endPoint.method {
        case .get:
            guard let snapshot = try await reference.getData().value as? Dictionary else {
                throw FireBaseError.invalidRequest
            }
            let models: [T] = try snapshot.compactMap { (_, data) in
                return try Parser.parse(data)
            }
            return models
        default:
            throw FireBaseError.invalidRequest
        }
    }
    
    public static func request(for endPoint: any RealtimeEndPoint) async throws {
        guard let reference = endPoint.path as? DatabaseReference else {
            throw FireBaseError.invalidPath
        }
        switch endPoint.method {
        case let .post(model):
            try await reference.setValue(model.asDictionary())
        case let .update(model):
            try await reference.updateChildValues(model.asDictionary())
        case .delete:
            try await reference.removeValue()
        default:
            throw FireBaseError.invalidRequest
        }
    }
}
