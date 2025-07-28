//
//  InsightsSectionView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

// MARK: - Insights Section View
struct InsightsSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Financial Insights")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
            
            VStack(spacing: 12) {
                InsightCard(
                    title: "Monthly Spending",
                    value: "EGP 12,450",
                    change: "-8.5%",
                    isPositive: true,
                    icon: "chart.line.downtrend.xyaxis",
                    color: .blue
                )
                
                InsightCard(
                    title: "Savings Goal",
                    value: "78% Complete",
                    change: "+15%",
                    isPositive: true,
                    icon: "target",
                    color: .green
                )
                
                InsightCard(
                    title: "Investment Returns",
                    value: "EGP 8,920",
                    change: "+23.4%",
                    isPositive: true,
                    icon: "chart.line.uptrend.xyaxis",
                    color: .purple
                )
            }
        }
    }
}
