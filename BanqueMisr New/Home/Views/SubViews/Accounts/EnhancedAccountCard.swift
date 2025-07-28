//
//  EnhancedAccountCard.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

struct EnhancedAccountCard: View {
    let account: AccountData
    let isBalanceVisible: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            // Smaller icon container
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: account.gradient),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 50)
                .overlay(
                    Text(account.icon)
                        .font(.system(size: 22))
                )
                .shadow(color: account.color.opacity(0.3), radius: 6, x: 0, y: 3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(account.type)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(account.color)
                
                Text(account.number)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.gray)
                
                HStack(alignment: .bottom, spacing: 3) {
                    Text("EGP")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                    
                    Text(isBalanceVisible ? account.balance : "•••••••••")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.primary)
                        .contentTransition(.numericText())
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                    .frame(width: 28, height: 28)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(14)
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.primary.opacity(0.01))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.primary.opacity(0.2), lineWidth: 0.5)
                )
                .frame(height: 100)
                .shadow(color: .primary.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.trailing, 0)
    }
}
