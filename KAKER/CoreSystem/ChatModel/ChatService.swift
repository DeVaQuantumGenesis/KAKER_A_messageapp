//
//  ChatService.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/26.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

struct ChatService{
    
    let chatPartner: User
    
     func sendMessage(_ messageText: String) {
        
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        
         let currentUserRef = FireStoreConstants.MessagesCollection.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = FireStoreConstants.MessagesCollection.document(chatPartnerId).collection(currentUid)
         
         let recentCurrentUserRef = FireStoreConstants.MessagesCollection.document(currentUid).collection("recent-messages").document(chatPartnerId)
         let recentPartnerRef = FireStoreConstants.MessagesCollection.document(chatPartnerId).collection("recent-messages").document(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(messageId: messageId,
                              fromId: currentUid,
                              toId: chatPartnerId,
                              messageText: messageText,
                              timestamp: Timestamp()
        )
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
         
         recentCurrentUserRef.setData(messageData)
         recentPartnerRef.setData(messageData)
    }
    
    func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let chatPartnerId = chatPartner.id
        
        let query = FireStoreConstants.MessagesCollection
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
    
        query.addSnapshotListener{ snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
            
            for (index, message) in messages.enumerated() where message.fromId != currentUid{
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
