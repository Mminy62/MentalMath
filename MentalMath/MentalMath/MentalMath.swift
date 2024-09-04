//
//  MentalMathApp.swift
//  MentalMath
//
//  Created by 이민영 on 8/29/24.
//

import SwiftUI

@main
struct MentalMath: App {
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MainView()
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case .mulmenu:
                            MulMenuView()
                        case .multable:
                            MulTableView()
                        case .mulrandom:
                            MulRandomView()
                        case .calculate(let title):
                            CalculateView(title: title)
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
