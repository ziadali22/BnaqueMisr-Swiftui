//
//  CardCarousel.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

struct HorizontalCardCarousel: View {

    @Binding var selectedCard: Card?
    @Binding var showCardDetails: Bool
    var animation: Namespace.ID
    var cards: [Card]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(cards) { card in
                    CardThumbnail(
                        card: card,
                        selectedCard: selectedCard,
                        showCardDetails: showCardDetails,
                        animation: animation,
                        onTap: {
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.5)) {
                                selectedCard = card
                                showCardDetails = true
                            }
                        }
                    )
                    .frame(width: 120)
                    .shadow(color: .primary.opacity(0.2), radius: 4, x: 0, y: 2)
                }
            }
//            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
    }
}
