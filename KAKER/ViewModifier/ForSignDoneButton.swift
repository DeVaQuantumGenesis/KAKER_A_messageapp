//
//  ForSignDoneButton.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/02.
//

import SwiftUI

struct ForSignDoneButton: ViewModifier{
    func body(content: Content) -> some View{
        content
            .foregroundColor(.white)
            .padding(20)
            .background{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.ultraThinMaterial)
            }
    }
}
