//
//  OffersView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 17/06/2025.
//

import SwiftUI

// MARK: - Main Offers View
struct OffersView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Offers Section")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(offersCardData) { offer in
                        OfferCard(offer: offer)
                    }
                }
//                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
        }
    }
}

// MARK: - Individual Offer Card
struct OfferCard: View {
    let offer: OffersViewCard
    
    var body: some View {
        ZStack {
            // Background Image
            Image(offer.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 320, height: 180)
                .clipped()
            
            // Gradient Overlay for better text readability
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.4),
                    Color.black.opacity(0.1),
                    Color.clear
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
            
            // Content Overlay
            HStack {
                // Left Side Content
                VStack(alignment: .leading, spacing: 8) {
                    // Brand Name (extracted from image name)
                    Text(offer.brandName)
                        .font(.system(size: 24, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .textCase(.uppercase)
                    
                    Spacer()
                    // Offer Title
                    Text(offer.title)
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                    
                    // Description
                    Text(offer.description)
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 20)
                
                Spacer()
                
                // Right Side Logo
                VStack {
                    Image(offer.logo)
                        .resizable()
                        .frame(width: 60, height: 60)
                    
                    Spacer()
                }
                .padding(.trailing, 20)
                .padding(.top, 20)
            }
        }
        .frame(width: 320, height: 180)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Data Model
struct OffersViewCard: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let logo: String
    let description: String
    
    // Computed property to extract brand name from image name
    var brandName: String {
        return image.capitalized
    }
}

// MARK: - Sample Data
let offersCardData: [OffersViewCard] = [
    OffersViewCard(
        image: "zara",
        title: "0% Interest",
        logo: "zaraLogo",
        description: "on all new collection"
    ),
    OffersViewCard(
        image: "addidas",
        title: "40% Cashback",
        logo: "addidasLogo",
        description: "on all men collection"
    ),
    OffersViewCard(
        image: "levis",
        title: "25% OFF",
        logo: "levisLogo",
        description: "on all women collection"
    ),
    OffersViewCard(
        image: "inglot",
        title: "20% Less Than Retail",
        logo: "inglotLogo",
        description: "on all makeup"
    )
]

// MARK: - Alternative Card Design (Minimalist)


// MARK: - Preview
#Preview {
    OffersView()
}
