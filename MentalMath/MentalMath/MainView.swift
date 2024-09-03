//
//  MainView.swift
//  MentalMath
//
//  Created by 이민영 on 9/2/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = CalculateViewModel.shared
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
//    @State private var operation: Operator = .plus

    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 50) {
                Image(uiImage: .logo)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, screenHeight / 10)
                
                VStack(alignment: .center, spacing: 20) {
                    HStack(alignment: .center, spacing: 20) {
                        NavigationLink(value: Operator.mul) {
                            Text("×")
                                .mainButtonStyle(height: screenHeight / 6, backgroundColor: Color.lightSkyBlue)
                        }
                        .navigationDestination(for: Operator.self) { textValue in
                            MulMenuView()
                                .onAppear {
                                    viewModel.op = textValue
                                }
                        }
                
                        NavigationLink(value: Operator.add) {
                            Text("+")
                                .mainButtonStyle(height: screenHeight / 6, backgroundColor: Color.lightCyan)
                        }
                        .navigationDestination(for: Operator.self) { textValue in
                        }
                    }
                    
                    HStack(alignment: .center, spacing: 20) {
                        NavigationLink(value: Operator.div) {
                            Text("÷")
                                .mainButtonStyle(height: screenHeight / 6, backgroundColor: Color.lightPurple)
                        }
                        .navigationDestination(for: Operator.self) { textValue in
                        }
                        
                        NavigationLink(value: Operator.sub) {
                            Text("-")
                                .mainButtonStyle(height: screenHeight / 6, backgroundColor: Color.lightIndigo)
                        }
                        .navigationDestination(for: Operator.self) { textValue in
                        }
                    }
                }
                .padding(.leading, screenWidth / 7)
                .padding(.trailing, screenWidth / 7)
                
                Color(.white).ignoresSafeArea()
                HStack {
                    Text("©️ 2024 Minyoung Lee")
                        .bold()
                }
                .padding(.bottom, 10)
            }
            
            
        }
    }
}

#Preview {
    MainView()
}
