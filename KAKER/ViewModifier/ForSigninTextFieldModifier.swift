//
//  ForSigninTextFieldModifier.swift
//  KAKER 2
//
//  Created by High Speed on 2024/10/29.
//

import SwiftUI

struct ForSigninTextFieldModifier: ViewModifier{
    func body(content: Content) -> some View{
        content
            .padding()
            .font(.system(size: 20))
            .autocapitalization(.none)
            .background{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.ultraThinMaterial)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 30)
    }
}
