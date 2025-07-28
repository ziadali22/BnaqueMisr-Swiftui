//
//  HeroPortoflioCardView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

// MARK: - Hero Portfolio Card View
struct HeroPortfolioCardView: View {
    @Binding var isBalanceVisible: Bool
    @Binding var animateCards: Bool
    let scrollOffset: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Total Portfolio")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                    
                    PortfolioBalanceView(isBalanceVisible: $isBalanceVisible)
                    
                    GrowthIndicatorView()
                }
                
                Spacer()
                
                PortfolioChartIconView(animateCards: $animateCards)
            }
            .padding(24)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.red,
                        Color.red.opacity(0.8),
                        Color.orange.opacity(0.6)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: .red.opacity(0.3), radius: 20, x: 0, y: 10)
        }
        .scaleEffect(animateCards ? 1.0 : 0.95)
        .opacity(animateCards ? 1.0 : 0.8)
        .offset(y: scrollOffset * 0.3)
    }
}

// MARK: - Portfolio Balance View
struct PortfolioBalanceView: View {
    @Binding var isBalanceVisible: Bool
    
    var body: some View {
        if isBalanceVisible {
            HStack(alignment: .bottom, spacing: 6) {
                Text("EGP")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                
                Text("732,616.52")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .contentTransition(.numericText())
            }
            .transition(.asymmetric(
                insertion: .scale.combined(with: .opacity),
                removal: .scale.combined(with: .opacity)
            ))
        } else {
            HStack(alignment: .bottom, spacing: 6) {
                Text("EGP")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                
                Text("••••••••")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
            }
            .transition(.asymmetric(
                insertion: .scale.combined(with: .opacity),
                removal: .scale.combined(with: .opacity)
            ))
        }
    }
}

// MARK: - Growth Indicator View
struct GrowthIndicatorView: View {
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "arrow.up.right")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.green)
            Text("+12.5% this month")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.white.opacity(0.15))
        .cornerRadius(20)
    }
}

// MARK: - Portfolio Chart Icon View
struct PortfolioChartIconView: View {
    @Binding var animateCards: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(Color.white)
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "chart.pie.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 22))
                        .rotationEffect(.degrees(animateCards ? 360 : 0))
                )
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            Text("Net worth")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
    }
}
