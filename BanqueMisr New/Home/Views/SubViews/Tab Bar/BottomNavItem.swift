//
//  BottomNavItem.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

struct BottomNavItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(Color.red.opacity(0.15))
                            .frame(width: 32, height: 32)
                            .transition(.scale.combined(with: .opacity))
                    }
                    
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: isSelected ? .semibold : .medium))
                        .foregroundColor(isSelected ? .red : .gray)
                }
                
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(isSelected ? .red : .gray)
            }
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(ScaleButtonStyle())
    }
}
