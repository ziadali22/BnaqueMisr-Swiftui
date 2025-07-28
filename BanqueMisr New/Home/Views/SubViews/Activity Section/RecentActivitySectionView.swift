//
//  RecentActivitySectionView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI
// MARK: - Recent Activity Section View
struct RecentActivitySectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Activity")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button("View All") {
                    // Handle view all
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.red)
            }
            
            VStack(spacing: 12) {
                ActivityRow(
                    icon: "arrow.up.right",
                    title: "Transfer to Ahmed",
                    subtitle: "Today, 2:30 PM",
                    amount: "-EGP 500",
                    isOutgoing: true
                )
                
                ActivityRow(
                    icon: "arrow.down.left",
                    title: "Salary Deposit",
                    subtitle: "Yesterday, 9:00 AM",
                    amount: "+EGP 15,000",
                    isOutgoing: false
                )
                
                ActivityRow(
                    icon: "creditcard",
                    title: "Online Purchase",
                    subtitle: "2 days ago",
                    amount: "-EGP 230",
                    isOutgoing: true
                )
            }
        }
    }
}
