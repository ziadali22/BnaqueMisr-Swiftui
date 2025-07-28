//
//  InsightCard.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

struct InsightCard: View {
    let title: String
    let value: String
    let change: String
    let isPositive: Bool
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(color.opacity(0.15))
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(color)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                
                Text(value)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                    .font(.system(size: 10, weight: .bold))
                Text(change)
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(isPositive ? .green : .red)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background((isPositive ? Color.green : Color.red).opacity(0.1))
            .cornerRadius(12)
        }
        .padding(16)

        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.08), radius: 5, x: 3, y: 3)
        )
        
        
    }
}
