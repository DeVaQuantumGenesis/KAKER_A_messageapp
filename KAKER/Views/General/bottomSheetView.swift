//
//  Untitled.swift
//  KAKER
//
//  Created by Naoki Takehara on 2025/03/04.
//
import SwiftUI

struct bottomSheetView<Content: View>: View{
    @Binding var isOpen: Bool
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    
    private var offset: CGFloat {
        isOpen ? 0 : (maxHeight - minHeight)
    }
    
    private var indicator: some View{
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.gray.opacity(0.3))
            .frame(
                width: 40,
                height: 6
            ).padding(5)
    }
    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self._isOpen = isOpen
        self.maxHeight = maxHeight
        self.minHeight = 35
        self.content = content()
    }
    
    var body: some View{
        GeometryReader { geometry in
            VStack(spacing: 0){
                self.indicator
                self.content
            }.padding()
                .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
                .background(.ultraThinMaterial)
                .cornerRadius(35)
                .frame(height: geometry.size.height, alignment: .bottom)
                .offset(y: max(self.offset + self.translation, 0))
                .animation(.bouncy(), value: isOpen)
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.height
                    }
                        .onEnded{ value in
                            let snapDistance = self.maxHeight * 0.25
                            guard abs(value.translation.height) > snapDistance else {
                                return
                            }
                            self.isOpen = value.translation.height < 0
                        }
                )
        }
    }
}
