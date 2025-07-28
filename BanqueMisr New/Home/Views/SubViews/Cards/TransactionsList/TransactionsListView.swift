//
//  TransactionsListView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI
// MARK: - Expense List View (Reusable)
struct TransactionsListView: View {
    let showTransactions: Bool
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 4), spacing: 16) {
                        QuickActionButton(
                            icon: "lockCard",
                            title: "Lock Card",
                            color: Color(.systemGray),
                            showBadge: true,
                            action: {}
                        )
                        
                        QuickActionButton(
                            icon: "manageCard",
                            title: "Manage Card",
                            color: Color(.systemGray),
                            action: {
                            }
                        )
                        
                    }
                    .padding(.bottom, 16)
                    
                    Text("Last Transactions")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.primary)
                    
                    LazyVStack(spacing: 16) {
                        ForEach(transactionsData) { transaction in
                            TransactionsCardView(transaction: transaction)
                        }
                    }
                    .padding(8)
                }
            }
            .frame(width: size.width, height: size.height)
            .offset(y: showTransactions ? 0 : size.height + 50)
        }
        .padding(.top)
    }
}

// MARK: - Expense Card View (Optimized)
struct TransactionsCardView: View {
    var transaction: Transactions
    @State var showView: Bool = false
    var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                
                Image(transaction.productIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                // Small badge circle
                Circle()
                    .fill(Color.brown)
                    .frame(width: 12, height: 12)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 8))
                            .foregroundColor(.white)
                    )
                    .overlay(
                        Circle()
                            .stroke(.white, lineWidth: 2)
                    )
            }
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                // Name
                Text(transaction.product)
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(1)
                
                // Amount
                Text(transaction.amountSpent)
                    .font(.system(size: 14, weight: .bold))
            }
            
            Spacer()
            
            // Right side content
              VStack(alignment: .trailing) {
                  
                  Button {
                      print("click three dots")
                  } label: {
                      // Three dots menu
                      HStack(spacing: 3) {
                          ForEach(0..<3) { _ in
                              Circle()
                                  .fill(Color.gray.opacity(0.6))
                                  .frame(width: 4, height: 4)
                          }
                      }
                  }
                  .padding(.bottom, 16)
                  
                  Spacer()
                  
                  // Date
                  Text(transaction.date)
                      .font(.system(size: 12))
                      .foregroundColor(.gray)
              }
        }
        
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.08), radius: 5, x: 3, y: 3)
        )
        .opacity(showView ? 1 : 0)
        .offset(y: showView ? 0 : 20)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.3).delay(Double(getIndex()) * 0.1)) {
                    showView = true
                }
            }
        }
        
    }
    
    func getIndex() -> Int {
        let index =  transactionsData.firstIndex { c1 in
            return c1.id == transaction.id
        } ?? 0
        
        return index < 20 ? index : 20
        
    }
}

struct Transactions: Identifiable {
    var id: String = UUID().uuidString
    var amountSpent: String
    var product: String
    var productIcon: String
    var date: String
    
}

var transactionsData: [Transactions] = [
    Transactions(amountSpent: "20,000 EGP", product: "Ahmed Ali Saaed", productIcon: "fisal", date: "29 March 2025"),
    Transactions(amountSpent: "4,293 EGP", product: "Ibrahim Ghaley El-Din", productIcon: "cib", date: "12 February 2025"),
    Transactions(amountSpent: "5,329 EGP", product: "Mahmoud Al-Ghazali", productIcon: "qnb", date: "10 February 2025"),
    Transactions(amountSpent: "3,000 EGP", product: "Sameir Ali Mohamed", productIcon: "misr", date: "05 February 2025"),
    Transactions(amountSpent: "258.6 EGP", product: "Lamya Ibrahim Abdo", productIcon: "adib", date: "25 Jaunary 2025"),
    Transactions(amountSpent: "452 EGP", product: "Alaa Nour Eldin", productIcon: "cib", date: "20 Jaunary 2025"),
    Transactions(amountSpent: "106 EGP", product: "Hanen El-Sayed Mohamed", productIcon: "fisal", date: "19 Jaunary 2025"),
    Transactions(amountSpent: "24.6 EGP", product: "Lamyaa Elsayed Ahmed", productIcon: "qnb", date: "17 Jaunary 2025"),
    Transactions(amountSpent: "1523.15 EGP", product: "Ragab Elsayed Waley", productIcon: "adib", date: "08 Jaunary 2025")
]
