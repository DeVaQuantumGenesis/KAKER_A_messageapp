//
//  ShowProfileImageView.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/09.
//

import SwiftUI
import Kingfisher

enum ShowProfileImageSize {
    case ForProfileScreen
    
    var dimension: CGFloat {
        switch self {
        case.ForProfileScreen: return .infinity
        }
    }
}
struct ShowProfileImageView: View{
    var user: User?
    
    let size: ShowProfileImageSize
    
    
    var body: some View{
        ZStack{
            
            if let imageUrl = user?.profileImageUrl{
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.dimension, height: size.dimension)
            } else {
                ZStack{
                    Rectangle()
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(width: size.dimension, height: size.dimension)
                }
            }
        }
    }
}
