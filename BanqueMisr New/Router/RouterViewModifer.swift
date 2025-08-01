//
//  RouterViewModifer.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 03/07/2025.
//

import Foundation
import SwiftUI


struct RouterViewModifer: ViewModifier {
    
    @State private var router = Router()
    
    private func routeView(for route: Route) -> some View {
        Group {
            switch route {
            case .transferToSelf:
                TransfersView()
            }
        }
        .environment(router)
    }
    
    func body(content: Content) -> some View {
        NavigationStack(path: $router.path) {
            content
                .environment(router)
                .navigationDestination(for: Route.self) { rotue in
                    routeView(for: rotue)
                }
        }
    }
}

extension View {
    public func router() -> some View {
        modifier(RouterViewModifer())
    }
}
