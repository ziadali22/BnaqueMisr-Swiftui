//
//  ActivityRow.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

struct ActivityRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let amount: String
    let isOutgoing: Bool
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill((isOutgoing ? Color.red : Color.green).opacity(0.15))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(isOutgoing ? .red : .green)
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(amount)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(isOutgoing ? .red : .green)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .background(
                    Group {
                        if colorScheme == .dark {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.green.opacity(0.3),
                                    Color.black.opacity(0.6)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        } else {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.green.opacity(0.3),
                                    Color.gray.opacity(0.1)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                )
                .shadow(color: .black.opacity(0.08), radius: 5, x: 3, y: 3)
        )
    }
}
