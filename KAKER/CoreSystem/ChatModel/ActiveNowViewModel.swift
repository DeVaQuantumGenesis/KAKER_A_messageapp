//
//  ActiveNowViewModel.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2025/02/02.
//

import Foundation
class ActiveNowViewModel: ObservableObject{
    @Published var users = [User]()
    
    init(){
        Task{
            try await fetchUsers()
        }
    }
    
    @MainActor
    private func fetchUsers() async throws{
        self.users = try await UserService.fetchAllUsers(limit: 10)
    }
}
