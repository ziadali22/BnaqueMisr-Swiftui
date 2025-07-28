//
//  ProfileAvatarView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//
import SwiftUI

struct ProfileAvatarView: View {
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red.opacity(0.8), Color.red]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 48, height: 48)
                .overlay(
                    Text("N")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                )
                .shadow(color: .red.opacity(0.3), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Welcome Back")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Text("Nadya Ali Hafez")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
            }
        }
    }
}
