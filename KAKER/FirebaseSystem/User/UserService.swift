//
//  UserService.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/02.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase

class UserService {
    
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws{
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    static func fetchUsers() async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return []  }
        
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
        return users.filter({ $0.id != currentUid })
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    func reset() {
        self.currentUser = nil
    }
    
    func  updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        try await Firestore.firestore().collection("users").document(currentUid).updateData([
            "profileImageUrl": imageUrl
        ])
        self.currentUser?.profileImageUrl = imageUrl
    }
    
    static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
        guard (Auth.auth().currentUser?.uid) != nil else { return []  }
        let query = FireStoreConstants.UserCollection
        if let limit{ query.limit(to: limit) }
        let snapshot = try await query.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
    
    static func chatfetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        FireStoreConstants.UserCollection.document(uid).getDocument{ snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else {return}
            completion(user)
        }
        
        print("")
    }

}
