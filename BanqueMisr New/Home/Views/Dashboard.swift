//
//  Dashboard.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

// MARK: - Main Banking Home View
struct Dashboard: View {
    @State private var selectedAccountIndex = 0
    @State private var selectedTab = 0
    @State private var isBalanceVisible = true
    @State private var showingTransfer = false
    @State private var scrollOffset: CGFloat = 0
    @State private var animateCards = false
    @State private var animateQuickActions = false
    @State private var pulseNotification = false
    
    // card
    @Namespace var animation
    @State var selectedCard: Card?
    @State var showCardDetails: Bool = false
    
    
    let cards: [Card] = [
        .init(cardImage: "card1"),
        .init(cardImage: "card2"),
        .init(cardImage: "card3"),
        .init(cardImage: "card4"),
        .init(cardImage: "card5")
    ]
    
    let accounts = [
        AccountData(
            type: "Premium Savings",
            number: "Account 38303330000113",
            balance: "591,024.6",
            icon: "🏦",
            color: Color.red,
            gradient: [Color.red, Color.red.opacity(0.7)]
        ),
        AccountData(
            type: "Current Account",
            number: "Account 38303330000114",
            balance: "2009.5",
            icon: "💳",
            color: Color.blue,
            gradient: [Color.blue, Color.blue.opacity(0.7)]
        ),
        AccountData(
            type: "Investment Account",
            number: "Account 38303330000115",
            balance: "139,582.1",
            icon: "📈",
            color: Color.purple,
            gradient: [Color.purple, Color.purple.opacity(0.7)]
        )
    ]
    
    var body: some View {
        GeometryReader { gemotery in
            VStack(spacing: 0) {
                // Custom Header
                DashBoardHeaderView(
                    isBalanceVisible: $isBalanceVisible,
                    pulseNotification: $pulseNotification,
                    animateCards: $animateCards,
                    scrollOffset: scrollOffset
                )
                
                // Main Content
                DashboardScrollContentView(
                    accounts: accounts,
                    selectedAccountIndex: $selectedAccountIndex,
                    isBalanceVisible: $isBalanceVisible,
                    showingTransfer: $showingTransfer,
                    scrollOffset: $scrollOffset,
                    animateCards: $animateCards,
                    animateQuickActions: $animateQuickActions,
                    animation: animation,
                    selectedCard: $selectedCard,
                    showCardDetails: $showCardDetails,
                    cards: cards
                )
                
            }
            .navigationBarHidden(true)
            .onAppear {
                startAnimations()
            }
            .overlay {
                if let selectedCard, showCardDetails {
                    CardDetailOverlay(card: selectedCard,
                                      animation: animation,
                                      showCardDetails: $showCardDetails)
                    .transition(.asymmetric(insertion: .identity,
                                            removal: .offset(y: 1)))
                    
                }
            }
//                .navigationDestination(isPresented: $showingTransfer) {
//                    TransfersView()
//                        .accentColor(.primary)
//                }

        }
    }
    
    private func startAnimations() {
        withAnimation(.easeInOut(duration: 0.6).delay(0.2)) {
            animateCards = true
        }
        
        withAnimation(.easeInOut(duration: 0.6).delay(0.2)) {
            animateQuickActions = true
        }
        
        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            pulseNotification = true
        }
        
    }
    
}

#Preview {
    Dashboard()
}
