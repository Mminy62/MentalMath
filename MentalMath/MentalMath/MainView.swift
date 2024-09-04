//
//  MainView.swift
//  MentalMath
//
//  Created by 이민영 on 9/2/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel = CalculateViewModel.shared
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 50) {
            Image(uiImage: .logo)
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.top, screenHeight / 10)
            
            VStack(alignment: .center, spacing: 20) {
                HStack(alignment: .center, spacing: 20) {
                    Button(action: {
                        viewModel.op = Operator.mul
                        router.navigate(to: .mulmenu)
                    }, label: {
                        Text("×")
                            .mainButtonStyle(height: screenHeight / 6, backgroundColor: Color.lightSkyBlue)
                    })
                    
                    Button(action: {
                        viewModel.op = Operator.add
//                        router.navigate(to: .)
                    }, label: {
                        Text("+")
                            .mainButtonStyle(height: screenHeight / 6, backgroundColor: Color.hintBackground)
                    })
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Button(action: {
                        viewModel.op = Operator.div
//                        router.navigate(to: .)
                    }, label: {
                        Text("÷")
                            .mainButtonStyle(height: screenHeight / 6, backgroundColor: Color.lightPurple)
                    })
                    
                    Button(action: {
                        viewModel.op = Operator.sub
//                        router.navigate(to: .)
                    }, label: {
                        Text("−")
                            .mainButtonStyle(height: screenHeight / 6, backgroundColor: Color.lightIndigo)
                    })
                }
            }
            .padding(.leading, screenWidth / 7)
            .padding(.trailing, screenWidth / 7)
            Color(.white).ignoresSafeArea()
            HStack {
                Text("©️ 2024 Minyoung Lee")
                    .foregroundStyle(.black)
                    .bold()
            }
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    MainView()
}
