//
//  AuthService.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/02.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore

class AuthService{
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init () {
        self.userSession = Auth.auth().currentUser
    }
    
    @Published var ErrorMessage = ""
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await UserService.shared.fetchCurrentUser()
        } catch let error as NSError {
            if error.code == AuthErrorCode.wrongPassword.rawValue{
                ErrorMessage = "Incorrect password"
            } else {
                ErrorMessage = error.localizedDescription
            }
            
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(withEmail: email, fullname: fullname, username: username, id: result.user.uid)
        } catch let error as NSError {
            
            ErrorMessage = error.localizedDescription
            
        }
    }
    
    func signOut(){
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.reset()
    }
    
    private func uploadUserData(
        withEmail email: String,
        fullname: String,
        username: String,
        id: String
    ) async throws{
        let user = User(id: id, fullname: fullname, email: email, username: username)
        
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        
        try await Firestore.firestore().collection("users").document(id).setData(
            userData
        )
        UserService.shared.currentUser = user
    }
}
