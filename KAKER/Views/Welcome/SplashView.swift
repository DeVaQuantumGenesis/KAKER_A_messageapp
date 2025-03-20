//
//  SplashView.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/22.
//

import SwiftUI

struct SplashView: View {
    @State var showSignInView = false
    var body: some View {
        ZStack{
            if showSignInView{
                intoro1()
            } else {
                WelcomeToView()
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 6){
                showSignInView = true
            }
        }
    }
}

#Preview {
    SplashView()
}
