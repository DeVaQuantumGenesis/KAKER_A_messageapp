//
//  ActiveNowView.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/24.
//

import SwiftUI

struct ActiveNowView: View {
    @StateObject var viewModel = ActiveNowViewModel()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 32){
                ForEach(viewModel.users, id: \.self) { user in
                    VStack{
                        ZStack(alignment: .bottomTrailing){
                            CircularProfileImageView(user: user, size: .ChatView1)
                            
                            ZStack{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 18, height: 18)
                                
                                Circle()
                                    .fill(Color(.systemGreen))
                                    .frame(width: 12, height: 12)
                            }
                        }
                        Text(user.username)
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}
