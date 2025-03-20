//
//  CircularProfileImage.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/12/19.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case EditView
    case Thread
    case ProfileCard
    case ProfileSee
    case ChatView2
    case ChatView1
    
    var dimension: CGFloat {
        switch self {
        case.EditView: return 160
        case.ProfileSee: return 120
        case.Thread: return 35
        case.ProfileCard: return 60
        case.ChatView1: return 64
        case.ChatView2: return 45
        }
    }
}
struct CircularProfileImageView: View{
    var user: User?
    
    let size: ProfileImageSize
    
    var body: some View{
        if let imageUrl = user?.profileImageUrl{
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            ZStack{
                Circle()
                    .foregroundStyle(.ultraThinMaterial)
                    .frame(width: size.dimension, height: size.dimension)
                
                Image(systemName: "person.fill")
                    .foregroundStyle(.white)
                    .font(.system(size: 40))
            }
        }
    }
}

