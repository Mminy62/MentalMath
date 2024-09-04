//
//  MulMenuView.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

struct MulMenuView: View {
    @EnvironmentObject var router: Router
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Button(action: {
                router.navigate(to: .multable)
            }, label: {
                Text("Multiplication Table")
                    .font(.system(size: 20))
                    .mainButtonStyle(height: screenHeight / 9, backgroundColor: Color.hintBackground)
            })
            Button(action: {
                router.navigate(to: .multable)
            }, label: {
                Text("Random Problems")
                    .font(.system(size: 20))
                    .mainButtonStyle(height: screenHeight / 9, backgroundColor: Color.lightPurple)
            })
            Spacer()
        }
        .padding(.leading, screenWidth / 7)
        .padding(.trailing, screenWidth / 7)
        .padding(.top, screenHeight / 8)
        .toolbarStyle(title: "Multiplication", onAutoButton: false)
    }
    
}

#Preview {
    MulMenuView()
}
