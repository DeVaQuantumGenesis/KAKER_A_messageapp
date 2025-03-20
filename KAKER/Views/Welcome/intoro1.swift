//
//  Untitled.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/02.
//

import SwiftUI

struct intoro1: View{
    @State private var isRotate = true
    @State private var isAnimate = true
    @State var show: Bool = false
    @State private var fullscreenLog = false
    var welcomeLogclass = WelcomeLogClass()
    var welcomeclass = WelcomeClass()
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                
                VStack{
                        Image("Logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .scaleEffect(show ? 1:0)
                        .animation(.smooth(duration: 2), value: show)
                        .padding(.bottom, 40)
                        
                        Text("Welcome to KAKER")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .overlay{
                                Rectangle()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: show ? 0 : .infinity)
                            }
                }
            }
            .fullScreenCover(isPresented: $fullscreenLog){
                SignInView()
            }
            .onAppear(){
                show.toggle()
            }
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button{
                        welcomeLogclass.WelcomeLogClass = true
                        fullscreenLog = true
                    } label: {
                        Text("Sign in with DeVa")
                            .foregroundStyle(.white)
                            .padding()
                            .font(.title)
                            .background{
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundStyle(.ultraThinMaterial)
                                    
                                
                            }
                            .blur(radius: show ? 0 : 10)
                            .opacity(show ? 1 : 0)
                            .scaleEffect(show ? 1: 0)
                            .animation(.smooth.delay(2), value: show)
                    }
                }
        }
        
        }
    }
}


#Preview {
    intoro1()
}
