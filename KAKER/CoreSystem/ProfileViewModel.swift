//
//  ProfileViewModel.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/02.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    
    
    private var cancellabels = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink{ [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellabels)
    }
    
}
