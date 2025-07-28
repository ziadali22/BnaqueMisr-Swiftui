//
//  TransfersView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 16/06/2025.
//

import SwiftUI

// MARK: - Main Transfers View
struct TransfersView: View {
    @State var amount: String = "15,000"

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TransferToSectionView()
                DeductAmountSectionView()
                TransferAmountTextField(amount: $amount)
                ScheduleView()
                ContinueButtonView()
            }
            .padding(16)
        }
        .navigationTitle("Transfers")
    }
}

// MARK: - Transfer To Section
struct TransferToSectionView: View {
    var body: some View {
        SectionView(
            title: "Transfer to",
            content: {
                RecipientCardViews(
                    initial: "N",
                    name: "Nabil Kallel",
                    bankName: "Banque Misr",
                    accountNumber: "5432 2352 2352 5251",
                    onChangeAction: {
                        print("Change recipient clicked")
                    }
                )
            }
        )
    }
}

// MARK: - Deduct Amount Section
struct DeductAmountSectionView: View {
    var body: some View {
        SectionView(
            title: "Deduct Amount From",
            content: {
                AccountCardView(
                    icon: "🏦",
                    accountType: "Current",
                    accountNumber: "5432 2352 2352 5251",
                    balance: "15,000 EGP",
                    onChangeAction: {
                        print("Change account clicked")
                    }
                )
            }
        )
    }
}

import SwiftUI

struct TransferAmountTextField: View {
    @Binding var amount: String
    @FocusState private var isFocused: Bool
    @State private var isValid: Bool = true
    var currencyPrefix: String = "EGP"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Transfer Amount")
                .font(.headline)
                .foregroundColor(.primary)

            HStack {
                Text(currencyPrefix)
                    .foregroundColor(.primary)
                    .padding(.leading, 16)

                TextField("15,000", text: $amount)
                    .font(.system(size: 18, weight: .bold))
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                    .onSubmit {
                        formatAmount()
                    }
                    .onChange(of: amount, initial: false) { newValue,_  in
                        validateInput(newValue)
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer() // pushes Done to right
                            Button("Done") {
                                formatAmount()
                                isFocused = false // hides keyboard
                            }
                            .foregroundColor(.moon)
                        }
                    }

                    .padding(.vertical, 16)
                    .background(Color.clear)
            }
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(isFocused ? Color.green : (isValid ? Color.gray.opacity(0.6) : Color.red), lineWidth: 1)
                    .scaleEffect(isFocused ? 1.02 : 1.0)
                    .animation(.easeInOut(duration: 0.25), value: isFocused)
            )
            if !isValid {
                Text("Enter a valid amount")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading, 4)
            }
        }
    }
    
    private func validateInput(_ text: String) {
        // Remove commas first
        let cleanText = text.replacingOccurrences(of: ",", with: "")
        
        // Allow only digits and at most one optional dot
        let filtered = cleanText.filter { "0123456789.".contains($0) }
        if filtered != cleanText {
            amount = filtered
        }

        // Regex for number with optional 2 decimal places
        let regex = #"^\d*\.?\d{0,2}$"#
        isValid = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: filtered)
    }
    private func formatAmount() {
        let cleanAmount = amount.replacingOccurrences(of: ",", with: "")
        guard let number = Double(cleanAmount) else { return }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = amount.contains(".") ? 2 : 0

        if let formatted = formatter.string(from: NSNumber(value: number)) {
            amount = formatted
        }
    }
}

struct ScheduleView: View {
    @State var isScheduleVisible: Bool = false
    
    var body: some View {
        HStack {
            Text("schedule this transfer".uppercased())
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.primary)
            
            Spacer()
            Toggle("", isOn: $isScheduleVisible)
                .labelsHidden()
                .tint(.moon)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 0.5)
        )
    }
}

struct ContinueButtonView: View {
    var body: some View {
        Button(action: {}) {
            Text("Continue")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(Color.moon)
                .cornerRadius(8)
        }
    }
}

// MARK: - Reusable Section Container
struct SectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
            
            content
        }
    }
}

// MARK: - Recipient Card Component
struct RecipientCardViews: View {
    let initial: String
    let name: String
    let bankName: String
    let accountNumber: String
    let onChangeAction: () -> Void
    
    var body: some View {
        CardView {
            HStack(spacing: 12) {
                AvatarView(text: initial)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                    
                    Text(bankName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(accountNumber)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                ChangeButton(action: onChangeAction)
            }
        }
    }
}

// MARK: - Account Card Component
struct AccountCardView: View {
    let icon: String
    let accountType: String
    let accountNumber: String
    let balance: String
    let onChangeAction: () -> Void
    
    var body: some View {
        CardView {
            HStack(spacing: 12) {
                AvatarView(text: icon)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(accountType)
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(.moon)
                    
                    Text(accountNumber)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(balance)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }
                
                Spacer()
                
                ChangeButton(action: onChangeAction)
            }
        }
    }
}

// MARK: - Reusable Card Container
struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.primary.opacity(0.01))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.primary.opacity(0.2), lineWidth: 0.5)
                    )
                    .shadow(color: .primary.opacity(0.1), radius: 4, x: 0, y: 2)
            )
    }
}

// MARK: - Avatar Component
struct AvatarView: View {
    let text: String
    
    var body: some View {
        Circle()
            .fill(Color.secondary.opacity(0.4))
            .frame(width: 50, height: 50)
            .overlay(
                Text(text)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            )
            .shadow(color: .moon.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Change Button Component
struct ChangeButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Change")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.moon)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .shadow(color: .primary.opacity(0.1), radius: 4, x: 0, y: 2)
                )
        }
    }
}

// MARK: - Preview
#Preview {
    TransfersView()
}
