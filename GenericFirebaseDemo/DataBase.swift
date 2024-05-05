//
//  DataBase.swift
//  GenericFirebaseDemo
//
//  Created by Nexios Mac 4 on 08/04/24.
//

import Foundation
import FirebaseFirestore

enum CollectionType: String {
    case user
}

enum DataBase {
    case createUser(user: UserModel)
    case getUser(id: String)
    case getAllUser
    case getUserName(id: String)
}

/*
extension DataBase: FireStoreEndPoint {
    var path: FirestoreReference {
        switch self {
        case let .createUser(user):
            return firestore.collection(CollectionType.user.rawValue.uppercased()).document(user.id)
        case let .getUser(id):
            return firestore.collection(CollectionType.user.rawValue.uppercased()).document(id)
        case .getAllUser:
            return firestore.collection(CollectionType.user.rawValue.uppercased())
        }
    }
    
    var method: FirebaseMethod {
        switch self {
        case let .createUser(user):
            return .post(user)
        case .getUser, .getAllUser:
            return .get
        }
    }
}
 */

extension DataBase: RealtimeEndPoint {
    var path: any RealtimeDatabaseReference {
        switch self {
        case let .createUser(user):
            return database.reference().child("Users/\(user.id)")
        case let .getUser(id):
            return database.reference().child("Users/\(id)")
        case .getAllUser:
            return database.reference().child("Users").queryLimited(toFirst: 1)
        case let .getUserName(id):
            return database.reference().child("Users/\(id)")
        }
    }
    
    var method: FirebaseMethod {
        switch self {
        case let .createUser(user):
            return .post(user)
        case .getUser, .getAllUser, .getUserName:
            return .get
        }
    }
}
