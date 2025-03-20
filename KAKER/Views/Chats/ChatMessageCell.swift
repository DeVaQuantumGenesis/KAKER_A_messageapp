//
//  ChatMessageCell.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/25.
//

import SwiftUI

struct ChatMessageCell: View{
    let message: Message
    
    private var isFromCurrentUser: Bool{
        return message.isFromCurrentUser
    }
    
    var body:some View{
        HStack{
            if isFromCurrentUser {
                Spacer()
                Text(message.messageText)
                    .font(.subheadline)
                    .padding(12)
                    .foregroundStyle(.white)
                    .background(Color(.systemBlue))
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            } else {
                HStack(alignment: .bottom, spacing: 8){
                    CircularProfileImageView(user: message.user, size: .ChatView2)
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .leading)
                    
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}
