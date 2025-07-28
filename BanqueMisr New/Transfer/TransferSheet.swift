//
//  TransferSheet.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

import SwiftUI

// MARK: - Domain Layer
struct TransferRecipient {
    let id: String
    let name: String
    let bankName: String
    let cardNumber: String
    let cardType: CardType
}

enum CardType {
    case visa
    case mastercard
    case amex
    
    var imageName: String {
        switch self {
        case .visa: return "creditcard.fill"
        case .mastercard: return "creditcard.fill"
        case .amex: return "creditcard.fill"
        }
    }
}

enum TransferCategory: String, CaseIterable {
    case movie = "Movie"
    case restaurant = "Restaurant"
    case groceries = "Groceries"
    
    var color: Color {
        switch self {
        case .movie: return .blue
        case .restaurant: return .gray
        case .groceries: return .gray
        }
    }
}

// MARK: - Presentation Layer - ViewModels
class TransferViewModel: ObservableObject {
    @Published var recipient: TransferRecipient
    @Published var amount: String = "20.50"
    @Published var selectedCategory: TransferCategory = .movie
    @Published var comment: String = ""
    @Published var keypadInput: String = ""
    
    init(recipient: TransferRecipient) {
        self.recipient = recipient
    }
    
    func updateAmount(with digit: String) {
        if digit == "." && keypadInput.contains(".") { return }
        if keypadInput.count < 8 {
            keypadInput += digit
            amount = keypadInput.isEmpty ? "0.00" : keypadInput
        }
    }
    
    func deleteLastDigit() {
        if !keypadInput.isEmpty {
            keypadInput.removeLast()
            amount = keypadInput.isEmpty ? "0.00" : keypadInput
        }
    }
    
    func sendTransfer() {
        // Implement transfer logic
        print("Sending $\(amount) to \(recipient.name)")
    }
}

// MARK: - Presentation Layer - Views
struct TransferView: View {
    @StateObject private var viewModel: TransferViewModel
    @Environment(\.colorScheme) var colorScheme
    
    init(recipient: TransferRecipient) {
        self._viewModel = StateObject(wrappedValue: TransferViewModel(recipient: recipient))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [
                        colorScheme == .dark ? Color(red: 0.15, green: 0.2, blue: 0.15) : Color(red: 0.95, green: 0.97, blue: 0.95),
                        colorScheme == .dark ? Color(red: 0.1, green: 0.1, blue: 0.1) : Color(red: 0.98, green: 0.98, blue: 0.98)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HeaderView()
                    
                    // Content Card
                    TransferContentView(viewModel: viewModel)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                                .shadow(
                                    color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.08),
                                    radius: 20,
                                    x: 0,
                                    y: 8
                                )
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                }
            }
        }
    }
}

struct HeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Button(action: {print("Return")}) {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            
            Spacer()
            
            Text("Transfer")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

struct TransferContentView: View {
    @ObservedObject var viewModel: TransferViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            // Recipient Section
            RecipientCardView(recipient: viewModel.recipient)
            
            // Amount Section
            AmountSectionView(amount: viewModel.amount)
            
            // Category Section
            CategorySectionView(
                selectedCategory: $viewModel.selectedCategory,
                categories: TransferCategory.allCases
            )
            
            // Comment Section
            CommentSectionView(comment: $viewModel.comment)
            
            // Keypad
            CustomKeypadView(viewModel: viewModel)
            
            // Send Button
            SendButtonView(amount: viewModel.amount) {
                viewModel.sendTransfer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 32)
    }
}

struct RecipientCardView: View {
    let recipient: TransferRecipient
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 16) {
            // Profile Image
            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1494790108755-2616b612b5bc?w=60&h=60&fit=crop&crop=face")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipient.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                HStack(spacing: 8) {
                    Text(recipient.bankName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("•")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("****" + String(recipient.cardNumber.suffix(4)))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Image(systemName: recipient.cardType.imageName)
                .font(.title2)
                .foregroundColor(.red)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(colorScheme == .dark ? Color(red: 0.15, green: 0.15, blue: 0.15) : Color(red: 0.98, green: 0.98, blue: 0.98))
        )
    }
}

struct AmountSectionView: View {
    let amount: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Amount")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("$\(amount)")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct CategorySectionView: View {
    @Binding var selectedCategory: TransferCategory
    let categories: [TransferCategory]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Category")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 12) {
                ForEach(categories, id: \.rawValue) { category in
                    CategoryButtonView(
                        category: category,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
                Spacer()
            }
        }
    }
}

struct CategoryButtonView: View {
    let category: TransferCategory
    let isSelected: Bool
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            Text(category.rawValue)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : (colorScheme == .dark ? .white : .black))
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color.red : (colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.2) : Color(red: 0.95, green: 0.95, blue: 0.95)))
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CommentSectionView: View {
    @Binding var comment: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 12) {
            TextField("Write a comment...", text: $comment)
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(colorScheme == .dark ? Color(red: 0.15, green: 0.15, blue: 0.15) : Color(red: 0.98, green: 0.98, blue: 0.98))
                )
        }
    }
}

struct CustomKeypadView: View {
    @ObservedObject var viewModel: TransferViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let keypadButtons = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "⌫"]
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<keypadButtons.count, id: \.self) { row in
                HStack(spacing: 24) {
                    ForEach(0..<keypadButtons[row].count, id: \.self) { col in
                        KeypadButtonView(
                            title: keypadButtons[row][col],
                            colorScheme: colorScheme
                        ) {
                            handleKeypadTap(keypadButtons[row][col])
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
    
    private func handleKeypadTap(_ key: String) {
        switch key {
        case "⌫":
            viewModel.deleteLastDigit()
        default:
            viewModel.updateAmount(with: key)
        }
    }
}

struct KeypadButtonView: View {
    let title: String
    let colorScheme: ColorScheme
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .frame(width: 60, height: 60)
                .background(
                    Circle()
                        .fill(Color.clear)
                )
        }
        .buttonStyle(KeypadButtonStyle())
    }
}

struct KeypadButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct SendButtonView: View {
    let amount: String
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            Text("Send $\(amount)")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [Color.blue, Color.blue.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
        }
        .buttonStyle(SendButtonStyle())
    }
}

struct SendButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - App Entry Point
struct TransferMoneyApp: App {
    var body: some Scene {
        WindowGroup {
            TransferView(recipient: sampleRecipient)
                .preferredColorScheme(nil) // Supports both light and dark mode
        }
    }
}

// MARK: - Sample Data
let sampleRecipient = TransferRecipient(
    id: "1",
    name: "Annet Robson",
    bankName: "101 Bank",
    cardNumber: "033232644423",
    cardType: .visa
)

// MARK: - Preview
struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransferView(recipient: sampleRecipient)
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
            
            TransferView(recipient: sampleRecipient)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
