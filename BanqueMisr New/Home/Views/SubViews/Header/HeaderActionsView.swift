//
//  HeaderActionsView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

// MARK: - Header Actions View
struct HeaderActionsView: View {
    @Binding var isBalanceVisible: Bool
    @Binding var pulseNotification: Bool
    @Binding var animateCards: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            ActionButton(icon: "arrow.clockwise", action: {})
                .rotationEffect(.degrees(animateCards ? 360 : 0))
            
            ActionButton(
                icon: isBalanceVisible ? "eye" : "eye.slash",
                action: {
                    withAnimation(.spring()) {
                        isBalanceVisible.toggle()
                    }
                }
            )
            
            ActionButton(icon: "bell", hasNotification: true, action: {})
                .scaleEffect(pulseNotification ? 1.1 : 1.0)
        }
    }
}
