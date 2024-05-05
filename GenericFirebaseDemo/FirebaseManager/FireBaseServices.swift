//
//  FireBaseServices.swift
//  GenericFirebaseDemo
//
//  Created by Nexios Mac 4 on 08/04/24.
//

import Foundation

protocol FireBaseServices {
    func signUp(with email: String, password: String) async throws -> UserModel
    
    func signIn(with email: String, password: String) async throws
    
    func createUser(for model: UserModel) async throws
    
    func getUser(for id: String) async throws -> UserModel
    
    func getAllUser() async throws -> [UserModel]
    
    func getUserName(handler: @escaping (Result<Dictionary, Error>) -> Void)
}
