//
//  StyleManager.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import Foundation
import SwiftUI

struct CommonButtonStyle: ViewModifier {
    var textColor: Color
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .bold()
            .font(.system(size: 20))
            .foregroundColor(textColor)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(backgroundColor)
                    .frame(width: 100, height: 35)
            )
    }
}

struct BoldTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .font(.system(size: 24))
    }
}

struct TextFieldUnderbarStyle: ViewModifier {
    let lineColor: Color
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .frame(height: 2.5)
                    .foregroundColor(lineColor),
                alignment: .bottom
            )
    }
}

extension View {
    func commomButtonStyle(textColor: Color, backgroundColor: Color) -> some View {
        self.modifier(CommonButtonStyle(textColor: textColor, backgroundColor: backgroundColor))
    }
    
    func boldTextStyle() -> some View {
        self.modifier(BoldTextStyle())
    }
    
    func textFieldUnderbarStyle(lineColor: Color) -> some View {
        self.modifier(TextFieldUnderbarStyle(lineColor: lineColor))
    }
}
