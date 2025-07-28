//
//  QuickActionsView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI
// MARK: - Quick Actions View
struct QuickActionsView: View {
    @Binding var showingTransferSheet: Bool
    @Binding var animateQuickActions: Bool
    @Environment(Router.self) var router
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Quick Actions")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
            
            HStack(alignment: .top, spacing: 32) {
                
                QuickActionButton(
                    icon: "applePay",
                    title: "Apple Pay",
                    color: .quickactionbg,
                    showBadge: true,
                    action: {}
                )
                
                QuickActionButton(
                    icon: "transferToSelf",
                    title: "Transfer to self",
                    color: .quickactionbg,
                    action: {
                        showingTransferSheet = true
                        router.navigateToTransferToSelf()
                    }
                )
                
                QuickActionButton(
                    icon: "telecom",
                    title: "Telecom & internet",
                    color: .quickactionbg,
                    action: {}
                )
                
                QuickActionButton(
                    icon: "cd",
                    title: "Open CD",
                    color: .quickactionbg,
                    action: {}
                )
            }
//            .padding(.top, 8)
        }
        .opacity(animateQuickActions ? 1.0 : 0.0)
        .offset(y: animateQuickActions ? 0 : 20)
    }
}
