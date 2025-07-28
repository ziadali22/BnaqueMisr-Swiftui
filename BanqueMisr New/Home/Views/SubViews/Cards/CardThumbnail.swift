//
//  CardThumbnail.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

struct CardThumbnail: View {
    let card: Card
    let selectedCard: Card?
    let showCardDetails: Bool
    var animation: Namespace.ID
    let onTap: () -> Void
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            if selectedCard?.id == card.id && showCardDetails {
                Rectangle()
                    .fill(.clear)
                    .frame(width: size.width, height: size.height)
            } else {
                Image(card.cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: card.id, in: animation)
                    .rotationEffect(.init(degrees: -90))
                    .frame(width: size.height, height: size.width)
                    .frame(width: size.width, height: size.height)
                    .contentShape(Rectangle())
                    .onTapGesture(perform: onTap)
            }
        }
        .frame(height: 180)
    }
}
