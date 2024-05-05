//
//  RealtimeEndPoint.swift
//  GenericFirebaseDemo
//
//  Created by AKASH BOGHANI on 05/05/24.
//

import Firebase

public protocol RealtimeEndPoint {
    var path: RealtimeDatabaseReference { get }
    var method: FirebaseMethod { get }
    var database: Database { get }
}

public extension RealtimeEndPoint {
    var database: Database {
        Database.database()
    }
}

public protocol RealtimeDatabaseReference {}

extension DatabaseQuery: RealtimeDatabaseReference {}
