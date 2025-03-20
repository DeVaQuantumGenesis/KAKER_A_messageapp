//
//  ChangePasswordView.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/12/20.
//

import SwiftUI
import FirebaseAuth

struct ChangePasswordView: View{
    @State private var Email = ""
    @State private var showEditProfile = false
    @State private var mailtip = false
    @State private var isSHowAllert = false
    @State private var mailTip2 = false
    @State private var appear = false
    @State private var appear2 = false
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ContentViewModel()
    var user: User?
    
    var body: some View{
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
                    Text("Change your Password")
                        .padding(.bottom ,50)
                        .foregroundStyle(.white)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    if viewModel.userSession != nil{
                        Text("email: \(String(describing: user?.email))")
                            .padding(.bottom, 20)
                    } else {
                        TextField("Email", text: $Email)
                            .modifier(ForSigninTextFieldModifier())
                            .padding(.bottom, 20)
                    }
                    
                    Button{
                        if viewModel.userSession != nil{
                            Email = user?.email ?? ""
                            Auth.auth().sendPasswordReset(withEmail: Email){ error in
                            }
                            mailtip = true
                        } else {
                            Auth.auth().sendPasswordReset(withEmail: Email){ error in
                            }
                            mailtip = true
                        }
                    } label: {
                        ZStack{
                            Text("Send an email")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .padding(.horizontal ,15)
                                .padding(.vertical, 12)
                                .background{
                                    RoundedRectangle(cornerRadius: 30)
                                        .foregroundStyle(.ultraThinMaterial)
                                }
                        }
                        .padding(.bottom, 20)
                    }
                    Button{
                        if viewModel.userSession != nil{
                            Email = user?.email ?? ""
                            Auth.auth().sendPasswordReset(withEmail: Email){ error in
                            }
                            mailTip2 = true
                        } else {
                            Auth.auth().sendPasswordReset(withEmail: Email){ error in
                            }
                            mailTip2 = true
                        }
                    } label: {
                        Text("Not receiving the email?")
                            .font(.system(size: 15))
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .alert("Sended",isPresented: $mailtip){
            Button("Close"){
                dismiss()
            }
        } message: {
            HStack{
                Image(systemName:"paperplane")
                Text("Email sent")
            }
        }
        .alert("Sended",isPresented: $mailTip2){
            Button("Close"){
                dismiss()
            }
        } message: {
            HStack{
                Image(systemName:"paperplane")
                Text("Email resend")
            }
        }
        .modifier(BackButtonModifier())
            
    }
}


//Modifier

struct ChangePasswordViewTitle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.system(size: 40))
            .foregroundColor(.white)
            .fontWeight(.bold)
    }
}

struct ChangePasswordViewButton: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.system(size: 20))
            .foregroundColor(.white)
            .padding(15)
            .background{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.ultraThinMaterial)
            }
    }
}
