//
//  DashboardTabBar.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

// MARK: - Bottom Navigation View

struct CustomTabView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            Dashboard()
                .tabItem {
                    EmptyView()
                }
                .tag(0)
            
            // Rewards Tab
            RewardsView()
                .tabItem {
                    EmptyView()
                }
                .tag(1)
            
            // Transfers Tab
            TransfersView()
                .tabItem {
                    EmptyView()
                }
                .tag(2)
            
            // Pay Tab
            PayView()
                .tabItem {
                    EmptyView()
                }
                .tag(3)
            
            // More Tab
            MoreView()
                .tabItem {
                    EmptyView()
                }
                .tag(4)
        }
        .overlay(
            DashboardTabBar(selectedTab: $selectedTab),
            alignment: .bottom
        )
    }
}

struct DashboardTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {

        HStack {
            BottomNavItem(
                icon: "house.fill",
                title: "Home",
                isSelected: selectedTab == 0
            ) {
                withAnimation(.spring()) {
                    selectedTab = 0
                }
            }
            
            BottomNavItem(
                icon: "gift",
                title: "Rewards",
                isSelected: selectedTab == 1
            ) {
                withAnimation(.spring()) {
                    selectedTab = 1
                }
            }
            
            BottomNavItem(
                icon: "arrow.left.arrow.right",
                title: "Transfers",
                isSelected: selectedTab == 2
            ) {
                withAnimation(.spring()) {
                    selectedTab = 2
                }
            }
            
            BottomNavItem(
                icon: "creditcard",
                title: "Pay",
                isSelected: selectedTab == 3
            ) {
                withAnimation(.spring()) {
                    selectedTab = 3
                }
            }
            
            BottomNavItem(
                icon: "ellipsis",
                title: "More",
                isSelected: selectedTab == 4
            ) {
                withAnimation(.spring()) {
                    selectedTab = 4
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .background(
            Color(.systemBackground),
            in: RoundedRectangle(cornerRadius: 20)
        )
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: -5)
        .ignoresSafeArea(.container, edges: .bottom)
    }
}
