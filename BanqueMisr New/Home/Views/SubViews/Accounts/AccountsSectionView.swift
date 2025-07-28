//
//  AccountsSectionView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI
// MARK: - Accounts Section View
struct AccountsSectionView: View {
    let accounts: [AccountData]
    @Binding var selectedAccountIndex: Int
    @Binding var isBalanceVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("My Accounts")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(isBalanceVisible ? "EGP 732,616.1": "•••••••")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                    .contentTransition(.numericText())
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(Array(accounts.enumerated()), id: \.offset) { index, account in
                        EnhancedAccountCard(
                            account: account,
                            isBalanceVisible: isBalanceVisible
                        )
                        .frame(width: UIScreen.main.bounds.width - 120)
                        .onTapGesture {
                            selectedAccountIndex = index
                        }
                    }
                }
//                .padding(.horizontal, 8)
            }
            .frame(height: 120)
        
        }
    }
}
