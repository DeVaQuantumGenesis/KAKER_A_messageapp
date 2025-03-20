//
//  SignInView.swift
//  KAKER 2
//
//  Created by High Speed on 2024/10/29.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject var viewModel = SignInViewModel()
    @State private var appear = false
    @State private var appear2 = false
    @FocusState var focuus:Bool
    
    var body: some View {
        NavigationStack{
        ZStack{
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .background{
                    MeshGradient(width: 3,
                                 height: 3,
                                 points: [
                                    [0.0, 0.0],[appear ? 0.5 : 1.0, 0.0],[1.0, 0.0],
                                    [0.0, 0.5],appear ? [0.1, 0.5] : [0.8 , 0.2], [1.0, -0.5],
                                    [0.0, 1.0],[1.0, appear2 ? 2.0 : 1.0],[1.0, 1.0]
                                 ],
                                 colors: [
                                    appear2 ? .red : .mint, appear2 ? .yellow : .cyan, .orange,
                                    appear ? .blue : .red, appear ? .cyan : .white, appear ? .red : .purple,
                                    appear ? .red: .cyan, appear ? .mint : .blue, appear2 ? .red : .blue
                                 ],
                                 smoothsColors: true,
                                 colorSpace: .perceptual
                    )
                    .onAppear{
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)){
                            appear.toggle()
                        }
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)){
                            appear2.toggle()
                        }
                    }
                }
                .ignoresSafeArea()
            
            ZStack{
                
                VStack{
                    Text("SignIn")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    TextField("Email", text: $viewModel.email)
                        .modifier(ForSigninTextFieldModifier())
                        .focused(self.$focuus)
                    
                    SecureField("Password", text: $viewModel.password)
                        .modifier(ForSigninTextFieldModifier())
                        .focused(self.$focuus)
                    
                    
                    
                    Button {
                        Task { try await viewModel.login()}
                    } label: {
                        Text("Sign In")
                            .modifier(ForSignDoneButton())
                        
                    }
                    if viewModel.errorMessage.isEmpty{
                        NavigationLink{
                            SignUpView()
                        } label: {
                            Text("Sign up")
                                .padding(.top)
                                .foregroundStyle(.white)
                        }
                    NavigationLink{
                        ChangePasswordView()
                    } label: {
                        Text("Forget a password?")
                            .padding(.top)
                            .foregroundStyle(.white)
                    }
                    } else {
                        VStack{
                            Text("ERROR")
                            Text(viewModel.errorMessage)
                                .foregroundStyle(.white)
                                .font(.caption)
                                .fontWeight(.semibold)
                            NavigationLink{
                                ChangePasswordView()
                            } label: {
                                Text("Forget a password?")
                                    .padding(.top)
                                    .foregroundStyle(.white)
                            }

                            }
                    }
                    
                    }
                }
            }
        }
        .overlay{
            if viewModel.isLoading == false{
                
            } else {
                ZStack{
                    Rectangle()
                        .foregroundStyle(.ultraThinMaterial)
                    VStack{
                        Text("Welcome back!")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .padding(.bottom, 30)
                            .foregroundStyle(.white)
                        Text("Loading...")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding()
                        
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

