//
//  FireStoreConstants.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/26.
//

import Foundation
import FirebaseFirestore

struct FireStoreConstants{
    static let UserCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
}
