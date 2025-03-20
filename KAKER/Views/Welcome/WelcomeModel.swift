//
//  WelcomeModel.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/22.
//

import SwiftUI

class WelcomeClass {
    @AppStorage("WelcomeClass") var WelcomeClass: Bool = false
}

struct WelcomeModel: View{
    var welcomeclass = WelcomeClass()
    var body: some View{
        if welcomeclass.WelcomeClass == false {
            SplashView()
                .onTapGesture{
                    welcomeclass.WelcomeClass = true
                }
        } else {
            SignInView()
        }
    }
}

