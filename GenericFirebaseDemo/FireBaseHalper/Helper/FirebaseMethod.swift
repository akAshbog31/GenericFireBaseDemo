//
//  FirebaseMethod.swift
//  GenericFirebaseDemo
//
//  Created by AKASH BOGHANI on 05/05/24.
//

import Foundation

public enum FirebaseMethod {
    case get
    case post(any FirebaseCodable)
    case update(any FirebaseCodable)
    case delete
}
