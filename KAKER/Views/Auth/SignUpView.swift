//
//  SignUpView.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/02.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var agreed: Bool = false
    @State private var appear = false
    @State private var appear2 = false
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
                    Text("Welcome to KAKER")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    TextField("Email", text: $viewModel.email)
                        .modifier(ForSigninTextFieldModifier())
                    
                    SecureField("Password", text: $viewModel.password)
                        .modifier(ForSigninTextFieldModifier())
                    
                    TextField("UserName", text: $viewModel.username)
                        .autocapitalization(.none)
                        .modifier(ForSigninTextFieldModifier())
                    
                    TextField("Date of birth", text: $viewModel.fullname)
                        .modifier(ForSigninTextFieldModifier())
                        .keyboardType(.decimalPad)
                    
                   
                    
                    Button {
                            Task{
                                try await viewModel.createUser()
                            }
                    } label: {
                        Text("Sign Up")
                            .modifier(ForSignDoneButton())
                    }
                    
                    
                    HStack{
                        Text("You have already an account?")
                            .foregroundColor(.white)
                        Button{
                            dismiss()
                        } label: {
                            Text("SignIn")
                                .foregroundColor(.white)
                            
                        }
                    }
                    if !viewModel.errorMessage.isEmpty{
                        VStack{
                            Text("ERROR")
                            Text(viewModel.errorMessage)
                                .foregroundStyle(.white)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .padding()
                            }
                    } else {
                        Text("By creating an account, you agree to KAKER's Terms of Use.")
                            .foregroundStyle(.white)
                            .lineLimit(nil)
                            .padding()
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
                        Text("Thank you for joining!")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .padding(.bottom, 30)
                            .foregroundStyle(.white)
                        Text("Loading...")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}
