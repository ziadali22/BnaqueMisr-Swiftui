//
//  DashBoardHeaderView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

// MARK: - Header View
struct DashBoardHeaderView: View {
    @Binding var isBalanceVisible: Bool
    @Binding var pulseNotification: Bool
    @Binding var animateCards: Bool
    let scrollOffset: CGFloat
    
    var body: some View {
        HStack {
            ProfileAvatarView()
            
            Spacer()
            
            HeaderActionsView(
                isBalanceVisible: $isBalanceVisible,
                pulseNotification: $pulseNotification,
                animateCards: $animateCards
            )
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .offset(y: scrollOffset * 0.5)
    }
}
