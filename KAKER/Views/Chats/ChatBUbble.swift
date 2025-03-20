//
//  ChatBUbble.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/25.
//

import SwiftUI

struct ChatBubble: Shape{
    let isFromCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [
                                    .topLeft,
                                    .topRight,
                                    isFromCurrentUser ? .bottomLeft : .bottomRight
                                ],
                                cornerRadii: CGSize(width: 16, height: 16))
        return Path(path.cgPath)
    }
}
