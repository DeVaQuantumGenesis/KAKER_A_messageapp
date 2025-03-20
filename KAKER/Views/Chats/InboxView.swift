//
//  InboxView.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/24.
//

import SwiftUI


struct InboxView: View{
    
    @State private var showNewMessageView = false
    @StateObject var viewModel = InboxViewModel()
    @State var selectedUser: User?
    @State private var SelectedUser: User?
    @State var showChat = false
    @State private var nowShowChat = false
    @Environment(\.dismiss) var dismiss
    private let edgeWidth: Double = 30
    private let baseDragWidth: Double = 30
    private var user: User? {
        return viewModel.currentUser
    }
    @State private var isPresented: Bool = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    private var  message = [Message]()
    
    var body: some View{
        NavigationStack{
            ZStack{
                ScrollView{
                    ActiveNowView()
                    List{
                        ForEach(viewModel.recentMessages) { message in
                            ZStack{
                                InboxRowView(message: message)
                                    .onTapGesture{
                                        nowShowChat = true
                                        SelectedUser = message.user
                                    }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: UIScreen.main.bounds.height)
                }
                bottomSheetView(isOpen: $isPresented, maxHeight: 500){
                    ScrollView{
                        VStack(spacing: 10) {
                                // グリッド部分
                                LazyVGrid(columns: columns, spacing: 10) {
                                    textColorButton()
                                    systemFontButton()
                                    coverButton()
                                    backdropButton()
                                    paperButton()
                                    stylesButton()
                                    separatorsButton()
                                }
                                .padding(.horizontal, 3)
                                
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding(.horizontal, 3)
                }
            }
            .navigationDestination(isPresented: $nowShowChat, destination: {
                if let nowuser = SelectedUser {
                    ChatView(user: nowuser)
                }
            })
            
            .navigationDestination(isPresented: $showChat, destination: {
                if let user = selectedUser {
                    ChatView(user: user)
                }
            })
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView(selectedUser: $selectedUser, showChat: $showChat)
            })
            
            .navigationBarBackButtonHidden(true)
            .gesture(
                DragGesture().onChanged{ value in
                    
                    if value.startLocation.x < edgeWidth && value.translation.width > baseDragWidth{
                        dismiss()
                    }
                    
                }
                
                
            )
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    HStack{
                        Text("KAKER")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.trailing)
                        Text("Beta")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                        Button{
                            isPresented = true
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                    }
                }
            }
        }
    }
    private func textColorButton() -> some View {
        Button(action: {
            AuthService.shared.signOut()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black)
                    .frame(width: 150, height: 150)
                
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .foregroundColor(.white)
                    
                    Text("Sign Out")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 14))
                }
            }
        }
    }
    
    private func systemFontButton() -> some View {
        Button{
            showNewMessageView.toggle()
            selectedUser = nil
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.4))
                VStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .foregroundColor(.white)
                    
                    Text("Search")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 14))
                }
            }
        }
    }
    
    private func coverButton() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 150, height: 130)
            
            VStack{
                Image(systemName: "person.2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white.opacity(0.7))
                
                Text("Group")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 14))
            }
        }
    }
    
    private func backdropButton() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
            
            Text("Backdrop")
                .foregroundColor(.white.opacity(0.7))
                .bold()
        }
    }
    
    private func paperButton() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black)
                .frame(width: 150, height: 130)
            
            VStack {
                Text("Paper")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .padding(.top, 5)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white.opacity(0.2))
                    .frame(height: 3)
            }
        }
    }
    
    private func stylesButton() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
            
            VStack(alignment: .leading) {
                Text("Styles")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 14))
                    .bold()
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black)
                    .frame(width: 50, height: 70)
                    .overlay(Text("Original").foregroundColor(.white).font(.system(size: 12, weight: .bold)), alignment: .topLeading)
            }
        }
    }
    
    private func separatorsButton() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
            
            VStack {
                Text("Separators")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 14))
                
                Spacer()
                
                Rectangle()
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 3)
            }
        }
    }
}
