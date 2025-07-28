//
//  CardsSectionView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

struct ScrollCardsView: View {
    
    // MARK: - Properties
    @Binding var selectedCard: Card?
    @Binding var showCardDetails: Bool
    var animation: Namespace.ID
    var cards: [Card]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("My Cards")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                
                HorizontalCardCarousel(selectedCard: $selectedCard,
                                       showCardDetails: $showCardDetails,
                                       animation: animation,
                                       cards: cards)
            }
            
            

        }
    }
}

struct Card: Identifiable {
    var id: String = UUID().uuidString
    var cardImage: String
}
