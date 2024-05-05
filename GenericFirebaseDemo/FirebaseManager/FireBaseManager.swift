//
//  FireBaseManager.swift
//  GenericFirebaseDemo
//
//  Created by Nexios Mac 4 on 08/04/24.
//

import Foundation
import FirebaseAuth

class FireBaseManager: FireBaseServices {
    func signUp(with email: String, password: String) async throws -> UserModel {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return UserModel(id: authResult.user.uid, email: authResult.user.email, createdAt: Date().formatted())
    }
    
    func signIn(with email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func createUser(for model: UserModel) async throws {
        try await RealtimeDatabaseService.request(for: DataBase.createUser(user: model))
    }
    
    func getUser(for id: String) async throws -> UserModel {
        return try await RealtimeDatabaseService.request(for: DataBase.getUser(id: id))
    }
    
    func getAllUser() async throws -> [UserModel] {
        return try await RealtimeDatabaseService.request(for: DataBase.getAllUser)
    }
    
    func getUserName(handler: @escaping (Result<Dictionary, any Error>) -> Void) {
        RealtimeDatabaseService.observe(for: DataBase.getUserName(id: Auth.auth().currentUser?.uid ?? ""), eventType: .value, handler: handler)
    }
}
