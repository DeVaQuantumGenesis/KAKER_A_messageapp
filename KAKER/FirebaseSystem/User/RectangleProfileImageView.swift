//
//  Untitled.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/07.
//

import SwiftUI
import Kingfisher

enum RectangleProfileImageSize {
    case ForProfileScreen
    
    var dimension: CGFloat {
        switch self {
        case.ForProfileScreen: return .infinity
        }
    }
}
struct RectangleProfileImageView: View{
    var user: User?
    
    let size: RectangleProfileImageSize
    
    var body: some View{
        ZStack{
            
            if let imageUrl = user?.profileImageUrl{
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: .infinity, height: .infinity)
                    .clipped()
                    .ignoresSafeArea()
            } else {
                ZStack{
                    Rectangle()
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(width: size.dimension, height: size.dimension)
                        .ignoresSafeArea()
                }
            }
        }
    }
}

struct RectangleProfileImageView2: View{
    var user: User?
        
    var body: some View{
        ZStack{
            if let imageUrl = user?.profileImageUrl{
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .blur(radius: .infinity)
                    .ignoresSafeArea()
            } else {
                ZStack{
                    Rectangle()
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(width: .infinity, height: .infinity)
                        .ignoresSafeArea()
                }
            }
        }
    }
}
