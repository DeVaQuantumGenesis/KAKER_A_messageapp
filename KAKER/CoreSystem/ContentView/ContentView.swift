//
//  ContentView.swift
//  KAKER 2
//
//  Created by High Speed on 2024/10/12.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group {
            if viewModel.userSession != nil{
                InboxView()
            } else{
                WelcomeLog()
            }
        }
    }
}

