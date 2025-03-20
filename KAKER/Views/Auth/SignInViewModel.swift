//
//  SignInViewModel.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/02.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    @MainActor
    func login() async throws {
        isLoading = true
            try await AuthService.shared.login(withEmail: email,
                                               password: password
            )
            errorMessage = AuthService.shared.ErrorMessage
            isLoading = false
    }
}
