//
//  Destination.swift
//  MentalMath
//
//  Created by 이민영 on 9/4/24.
//

import Foundation
import SwiftUI

enum Destination: Hashable {
    case mulmenu
    case multable
    case mulrandom
    case calculate(String)
}

final class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to destination: Destination) {
        path.append(destination)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
