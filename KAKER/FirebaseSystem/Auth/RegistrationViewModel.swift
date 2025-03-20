//
//  RegistrationViewModel.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/02.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var fullname = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    @MainActor
    func createUser() async throws {
        isLoading = true
        
            try await AuthService.shared.createUser(withEmail: email,
                                                    password: password,
                                                    fullname: fullname,
                                                    username: username
            )
        errorMessage = AuthService.shared.ErrorMessage
        isLoading = false
    }
}
