//
//  EndPoint.swift
//  GenericFirebaseDemo
//
//  Created by Nexios Mac 4 on 08/04/24.
//

import FirebaseFirestore

public protocol FireStoreEndPoint {
    var path: FirestoreReference { get }
    var method: FirebaseMethod { get }
    var firestore: Firestore { get }
}

public extension FireStoreEndPoint {
    var firestore: Firestore {
        Firestore.firestore()
    }
}

public protocol FirestoreReference {}

extension DocumentReference: FirestoreReference {}
extension Query: FirestoreReference {}
