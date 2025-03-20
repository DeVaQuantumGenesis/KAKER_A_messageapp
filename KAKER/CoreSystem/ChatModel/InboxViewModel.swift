//
//  InboxViewModel.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/25.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class InboxViewModel: ObservableObject{
    @Published var currentUser: User?
    
    @Published var recentMessages = [Message]()

    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    
    init () {
        setupSubscribers()
        service.observeRecentMessages()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
        
        service.$documentChanges.sink { [weak self] changes in
            self?.loadInitalMessages(fromChanges: changes)
        }.store(in: &cancellables)
    }
    private func loadInitalMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
        
        for i in 0 ..< messages.count{
            let message = messages[i]
            UserService.chatfetchUser(withUid: message.chatPartnerId){ user in
                messages[i].user = user
                self.recentMessages.append(messages[i])
            }
        }
    }
}
