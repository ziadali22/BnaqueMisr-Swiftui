//
//  ContentView.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 13/06/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    var body: some View {
        CustomTabView()
            .router()
            .tint(.primary)
            .preferredColorScheme(userTheme.colorScheme)
    }
}

#Preview {
    ContentView()
}
