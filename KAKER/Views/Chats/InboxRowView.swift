
//
//  Inforo.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/24.
//

import SwiftUI

struct InboxRowView: View {
    var user: User?
    let message: Message
    var body: some View {
        HStack(alignment: .top, spacing: 12){
            CircularProfileImageView(user: message.user, size: .ChatView1)
            
            VStack(alignment: .leading, spacing: 4){
                Text(message.user?.username ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(width: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack{
                //Text(message.timestampString)
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
        }
        .frame(height: 72)
    }
}
