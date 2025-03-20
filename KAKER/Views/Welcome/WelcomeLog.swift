//
//  WelcomeLog.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/12/06.
//

import SwiftUI

class WelcomeLogClass {
    @AppStorage("WelcomeLogClass") var WelcomeLogClass: Bool = false
}

struct WelcomeLog: View{
    var welcomeLogclass = WelcomeLogClass()
    var body: some View{
        if welcomeLogclass.WelcomeLogClass == true{
            SignInView()
        } else if welcomeLogclass.WelcomeLogClass == false{
            SplashView()
        } else {
            
        }
    }
}
