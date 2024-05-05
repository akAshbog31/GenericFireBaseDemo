//
//  UserModel.swift
//  GenericFirebaseDemo
//
//  Created by Nexios Mac 4 on 08/04/24.
//

import Foundation

struct UserModel: FirebaseCodable {
    var id: String
    var name: String?
    var email: String?
    var createdAt: String
    
    init() {
        self.id = UUID().uuidString
        self.createdAt = Date().formatted()
    }
    
    init(id: String, name: String? = nil, email: String? = nil, createdAt: String) {
        self.id = id
        self.name = name
        self.email = email
        self.createdAt = createdAt
    }
}
