//
//  ChatView.swift
//  KAKER 2
//
//  Created by Naoki Takehara on 2024/11/25.
//

import SwiftUI
import Kingfisher

struct ChatView:View{
    @StateObject var viewModel: ChatViewModel
    
    let user: User
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    private let edgeWidth: Double = 30
    private let baseDragWidth: Double = 30
    
    @State var isSplit = false
    @State private var shakeOffset: CGFloat = 0
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    let sounds: [Sound] = [Sound(id: 1004, soundName: "SMSSent")]
    @State var isPressed = false
    @State var showFirst = true
    @State var showSecond = true
    @State var showThird = true
    @FocusState var focus: Bool
    
    var body: some View{
        ZStack{
            Color.orange
                .ignoresSafeArea()
                

            VStack{
                ScrollView{
                    ScrollViewReader{ proxy in
                        VStack{
                        ForEach( viewModel.messages ){ message in
                            ChatMessageCell(message: message)
                        }
                    }
                        .onAppear{
                            proxy.scrollTo(99, anchor: .bottom)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                ZStack{
                    VStack {
                        HStack(spacing: 10) {
                                
                         NavigationLink{
                             
                         }label: {
                             ZStack{
                                 Capsule()
                                     .frame(width: 80, height: 30)
                                     .foregroundStyle(.ultraThinMaterial)
                                 Image(systemName: "apple.intelligence")
                                     .foregroundStyle(colorScheme == .dark ? .white : .black)
                             }
                             .opacity(showFirst ? 1 : 0)
                             .scaleEffect(showFirst ? 1 : 0.5)
                             .animation(.easeOut(duration: 0.5), value: showFirst)
                         }
                            
                            NavigationLink{
                                
                            }label: {
                                ZStack{
                                    Capsule()
                                        .frame(width: 80, height: 30)
                                        .foregroundStyle(.ultraThinMaterial)
                                    Image(systemName: "camera")
                                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                                }
                                .offset(x: showSecond ? 0 : -30)
                                .opacity(showSecond ? 1 : 0)
                                .animation(.easeOut(duration: 0.3).delay(0.3), value: showSecond)
                            }
                            
                            NavigationLink{
                                
                            } label: {
                                ZStack{
                                    Capsule()
                                        .frame(width: 80, height: 30)
                                        .foregroundStyle(.ultraThinMaterial)
                                    Image(systemName: "hand.thumbsup.fill")
                                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                                }
                                .offset(x: showThird ? 0 : -30)
                                .opacity(showThird ? 1 : 0)
                                .animation(.easeOut(duration: 0.05).delay(0.6), value: showThird)
                            }
                        }
                        HStack(spacing: isSplit ? 10 : 0) {
                            // 左側のボタン or テキストフィールド
                            if isSplit {
                                TextField("入力してください", text: $viewModel.messageText, axis: .vertical)
                                    .focused($focus)
                                    .padding(.vertical)
                                    .padding(.horizontal, 4)
                                    .background(
                                        ButtonPart(isLeft: false)
                                            .cornerRadius(15)
                                    )
                                    .frame(width: 300, height: 60)
                                    .offset(x: isSplit ? -10 : 0)
                                    .offset(x: shakeOffset)
                            } else {
                                ButtonPart(isLeft: true)
                                    .frame(width: 300, height: 60)
                                    .cornerRadius(15)
                                    .offset(x: shakeOffset)
                            }
                            
                            // 右側の小さいボタン
                            
                            ZStack{
                                ButtonPart(isLeft: false)
                                Image(systemName: "paperplane")
                            }
                            .frame(width: isSplit ? 50 : 0, height: isSplit ? 50 : 60)
                            .cornerRadius(isSplit ? 25 : 15)
                            .offset(x: isSplit ? 10 : 0)
                            .offset(x: -shakeOffset)
                            .opacity(isSplit ? 1 : 0)
                            .scaleEffect(isPressed ? 1.2 : 1.0)
                            .onTapGesture{
                                Task{
                                    AudioServicesPlayAlertSound(1004)
                                    viewModel.sendMessage()
                                    viewModel.messageText = ""
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0)){
                                        isPressed.toggle()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.12){
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0)){
                                            isPressed.toggle()
                                        }
                                    }
                                }
                            }
                        }
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isSplit)
                    }
                    .frame(width: 200, height: 60)
                    .onTapGesture {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.32){
                            self.focus = true
                        }
                        if isSplit == false{
                            withAnimation {
                                isSplit.toggle()
                            }
                            showFirst = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
                                showSecond = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                                showThird = false
                            }
                            
                        } else {
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .onTapGesture{
                isSplit = false
                showFirst = true
                showSecond = true
                showThird = true
                self.focus = false
        }
        .navigationBarBackButtonHidden(true)
        .gesture(
            DragGesture().onChanged{ value in
                
                if value.startLocation.x < edgeWidth && value.translation.width > baseDragWidth{
                    dismiss()
                }
                
            }
            
            
        )
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                HStack{
                    Button{
                        dismiss()
                        
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.ultraThinMaterial)
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.trailing)
                    
                    CircularProfileImageView(user: user, size: .ChatView2)
                        .padding(.horizontal)
                    
                    Text(user.fullname)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
            }
        }
    }
    func startShaking() {
        let shakeAmount: CGFloat = 8
        withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(1, autoreverses: true)) {
            shakeOffset = shakeAmount
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                shakeOffset = 0
            }
        }
    }
}

import AudioToolbox

struct Sound: Identifiable{
    let id: SystemSoundID
    let soundName: String
}


struct ButtonPart: View {
    let isLeft: Bool
    var body: some View {
        Rectangle()
            .foregroundStyle(.ultraThinMaterial)
            
    }
}
