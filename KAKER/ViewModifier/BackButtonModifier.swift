//
//  BackButtonModifier.swift
//  KAKER 2
//
//  Created by High Speed on 2024/10/30.
//

import SwiftUI

struct BackButtonModifier: ViewModifier{
    @Environment(\.dismiss) var dismiss
    
    private let edgeWidth: Double = 30
    private let baseDragWidth: Double = 30
    
    func body(content: Content) -> some View{
        content
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
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
                }
            }
            .gesture(
                DragGesture().onChanged{ value in
                    
                    if value.startLocation.x < edgeWidth && value.translation.width > baseDragWidth{
                        dismiss()
                    }
                    
                }
                
                
            )
        
    }
}
