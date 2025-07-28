//
//  ActionButton.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI
// MARK: - Supporting Views (kept the same)

struct ActionButton: View {
    let icon: String
    let hasNotification: Bool
    let action: () -> Void
    
    init(icon: String, hasNotification: Bool = false, action: @escaping () -> Void) {
        self.icon = icon
        self.hasNotification = hasNotification
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color(.secondarySystemBackground))
                    .frame(width: 30, height: 30)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.primary)
                
                if hasNotification {
                    VStack {
                        HStack {
                            Spacer()
                            Circle()
                                .fill(Color.red)
                                .frame(width: 8, height: 8)
                        }
                        Spacer()
                    }
                    .frame(width: 30, height: 30)
                }
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let showBadge: Bool
    let action: () -> Void
    
    init(icon: String, title: String, color: Color, showBadge: Bool = false, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.color = color
        self.showBadge = showBadge
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .center, spacing: 12) {
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 56, height: 56)
                    
                    Image(icon)
                        .font(.system(size: 24, weight: .medium))
                    
                    if showBadge {
                        VStack {
                            HStack {
                                Spacer()
                                Text("New")
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.red)
                                    .cornerRadius(8)
                                    .offset(x: 8, y: -5)
                            }
                            Spacer()
                        }
                        .frame(width: 56, height: 56)
                    }
                }
                
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
