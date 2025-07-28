//
//  Router.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 03/07/2025.
//

import Foundation
import SwiftUI
import Observation

@Observable
class Router {
    var path = NavigationPath()
    
    func navigateToTransferToSelf() {
        path.append(Route.transferToSelf)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

enum Route: Hashable {
    case transferToSelf
}
