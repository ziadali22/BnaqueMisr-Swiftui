//
//  CardDetailOverlay.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

struct CardDetailOverlay: View {
    let card: Card
    var animation: Namespace.ID
    @Binding var showCardDetails: Bool
    @State private var showCardDetailsContent: Bool = false
    @State private var showTransactions: Bool = false
    
    var body: some View {
        ZStack {
            // Background blur/dim
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    closeDetailView()
                }
            
            // Detail content
            VStack {
                DetailViewHeader(
                    showContent: showCardDetailsContent,
                    onClose: closeDetailView
                )
                
                DetailViewCardImage(
                    card: card,
                    showCardDetailsContent: showCardDetailsContent,
                    animation: animation
                )
                
                TransactionsListView(showTransactions: showTransactions)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.regularMaterial)
            )
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                showCardDetailsContent = true
            }
            withAnimation(.easeInOut(duration: 0.5).delay(0.05)) {
                showTransactions = true
            }
            
            
        }
    }
    
    private func closeDetailView() {
        withAnimation(.easeInOut(duration: 0.4)) {
            showCardDetailsContent = false
            showTransactions = false
            showCardDetails = false
        }
    }
}

// MARK: - Detail View Components (Reusable)
struct DetailViewHeader: View {
    let showContent: Bool
    let onClose: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onClose) {
                HStack(spacing: 8) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                    
                    Text("Close")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                }
            }
            
            Spacer()
        }
        .padding(.bottom, 15)
        .opacity(showContent ? 1 : 0)
    }
}

struct DetailViewCardImage: View {
    let card: Card
    var showCardDetailsContent: Bool
    let animation: Namespace.ID
    
    var body: some View {
        Image(card.cardImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: card.id, in: animation)
            .rotationEffect(.init(degrees: showCardDetailsContent ? 0 : -90))
            .frame(height: 220)
            .shadow(color: .primary.opacity(0.03), radius: 8, x: 0, y: 4)
    }
}
