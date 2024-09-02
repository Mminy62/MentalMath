//
//  MulMenuView.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

struct MulMenuView: View {
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            NavigationLink {
                MulTableView()
            } label: {
                Text("Multiplication Table")
                    .font(.system(size: 20))
                    .mainButtonStyle(height: screenHeight / 9, backgroundColor: Color.lightCyan)
            }
            
            NavigationLink {
                MulRandomView()
            } label: {
                Text("Random Problems")
                    .font(.system(size: 20))
                    .mainButtonStyle(height: screenHeight / 9, backgroundColor: Color.lightPurple)
            }
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
