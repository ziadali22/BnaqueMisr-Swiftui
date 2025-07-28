//
//  MoreView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 16/06/2025.
//

import SwiftUI

struct MoreView: View {
    var menueOptions: [MainMenueOptions] = [
        .init(title: "Apply For New Produt", icon: "newProduct", color: .green),
        .init(title: "Loan Offers", icon: "loanOffers", color: .indigo),
        .init(title: "Manage My Cards", icon: "manageMyCards", color: .blue),
        .init(title: "Manage Reminders", icon: "manageReminder", color: .pink),
        .init(title: "Change Services", icon: "changeService", color: .mint),
        .init(title: "Service Request Status", icon: "serviceRequest", color: .mint),
        .init(title: "Nearest branch or ATM", icon: "branchLocator", color: .mint),
        .init(title: "Exchange rates", icon: "exchangeRates", color: .mint)
        
    ]
    
    var settingsOptions: [MainMenueOptions] = [
        .init(title: "Change Theme", color: .sun),
        .init(title: "Schedule Branch Visit", color: Color(.label)),
        .init(title: "Soft Token", color: Color(.label)),
        .init(title: "Settings", color: Color(.label)),
        .init(title: "FAQ", color: Color(.label)),
        .init(title: "Contact US", color: Color(.label)),
        .init(title: "Logout", color: .moon)
    ]
    
    @State private var changeTheme: Bool = false
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        NavigationView {
            List {
                Section("Profile") {
                    NavigationLink(destination: Text("Profile")) {
                        HStack(spacing: 16) {
                            Image("nadya")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50 , height: 50)
                                .clipShape(Circle())
                                .padding(.vertical, 4)
                            Text("Nadya Ali Hafez")
                                .font(.headline)
                        }
                    }
    
                }
                Section("Apperance") {
                    ForEach(menueOptions, id: \.title) { options in
                        NavigationLink(value: options) {
                            HStack {
                                Image(options.icon ?? "")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                Text(options.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                    }
                }
                Section("Settings") {
                    HStack {
                        Text("Language")
                            .font(.headline)
                            .foregroundStyle(.primary)
                        Spacer()
                        HStack(spacing: 8){
                            Button {
                                
                            } label: {
                                Text("English")
                                    .foregroundStyle(.white)
                                    .padding(4)
                                    .background(Color.moon.opacity(0.9))
                                    .cornerRadius(4)
                            }
                            Button {
                                
                            }label: {
                                Text("Arabic")
                                    .foregroundStyle(Color(.label))
                            }
                        }
                        .padding(4)
                        .padding(.horizontal, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.gray.opacity(0.1))
                        )
                        
                    }
                    ForEach(settingsOptions, id: \.title) { options in
                        Button {
                            changeTheme.toggle()
                        } label: {
                            Text(options.title)
                                .font(.headline)
                                .foregroundStyle(Color(.label))
                        }
                    }


                }
            }

            .navigationTitle("More Options")
        }
        .sheet(isPresented: $changeTheme) {
            ChangeThemeView(scheme: scheme)
                .presentationDetents([.height(400)])
                .presentationBackground(.clear)
        }
    }
}

#Preview {
    MoreView()
}


struct MainMenueOptions: Hashable {
    var title: String
    var icon: String? = nil
    var color: Color? = Color(.label)
}

