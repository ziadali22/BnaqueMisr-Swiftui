//
//  DashboardScrollContentView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI
// MARK: - Scroll Content View
struct DashboardScrollContentView: View {
    let accounts: [AccountData]
    @Binding var selectedAccountIndex: Int
    @Binding var isBalanceVisible: Bool
    @Binding var showingTransfer: Bool
    @Binding var scrollOffset: CGFloat
    @Binding var animateCards: Bool
    @Binding var animateQuickActions: Bool
    
    // Cards
    var animation: Namespace.ID
    @Binding var selectedCard: Card?
    @Binding var showCardDetails: Bool
    var cards: [Card]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 24) {
                // Hero Portfolio Card
                HeroPortfolioCardView(
                    isBalanceVisible: $isBalanceVisible,
                    animateCards: $animateCards,
                    scrollOffset: scrollOffset
                )
                
                // Quick Actions
                QuickActionsView(
                    showingTransferSheet: $showingTransfer,
                    animateQuickActions: $animateQuickActions
                )
                
                // Accounts Section
                AccountsSectionView(
                    accounts: accounts,
                    selectedAccountIndex: $selectedAccountIndex,
                    isBalanceVisible: $isBalanceVisible
                )
                
                ScrollCardsView(selectedCard: $selectedCard,
                                showCardDetails: $showCardDetails,
                                animation: animation,
                                cards: cards)
                
                
                // Insights Section
                InsightsSectionView()
                OffersView()
                
                // Recent Activity
//                RecentActivitySectionView()
                
                Spacer(minLength: 120)
            }
            .padding(.horizontal, 20)
            .background(
                GeometryReader { geo in
                    Color.clear.preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: geo.frame(in: .named("scroll")).minY
                    )
                }
            )
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea()
    }
}
