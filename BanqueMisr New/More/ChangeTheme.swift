//
//  ChangeTheme.swift
//  BanqueMisr New
//
//  Created by Ziad Khalil on 16/06/2025.
//

import SwiftUI

struct ChangeThemeView: View {
    var scheme: ColorScheme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @Namespace private var animation
    @State private var circleOffset: CGSize
    
    init(scheme: ColorScheme) {
        self.scheme = scheme
        let isDark = scheme == .dark
        _circleOffset = .init(initialValue: CGSize(width: isDark ? 30 : 150, height: isDark ? -25 : -150))
    }
    
    var body: some View {
        VStack(spacing: 16) {
        
            Text("Change App Theme Color")
                .font(.title2.bold())
                .padding(.top, 16)
                .padding(.bottom, 16)
        
            HStack(spacing: 0) {
                ForEach(Theme.allCases, id: \.rawValue) { theme in
                    
                    VStack {
                        Image(theme.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 150)
                            .cornerRadius(10)
                            .padding()
                            .shadow(color: .primary.opacity(0.06), radius: 8, x: 0, y: 4)
                            .onTapGesture {
                                userTheme = theme
                            }
                        
                        VStack {
                            Text(theme.rawValue)
                                .padding(.vertical, 10)
                                .frame(width: 80)
                                .foregroundStyle(.white)
                                .background {
                                    ZStack {
                                        if userTheme == theme {
                                            Capsule()
                                                .fill(.moon)
                                                .matchedGeometryEffect(id: "Active", in: animation)
                                        }
                                    }
                                    .animation(.snappy, value: userTheme)
                                }
                                .contentShape(.rect)
                                .onTapGesture {
                                    userTheme = theme
                                }
                        }
                        .padding(3)
                        .background(.primary.opacity(0.2), in: .capsule)
                        
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 400)
        .background(Color(.systemBackground))
        .clipShape(.rect(cornerRadius: 30))
        .padding(.horizontal, 15)
        .environment(\.colorScheme, scheme)
        .onChange(of: scheme, initial: false ) {_ , newValue in
//            let isDark = newValue == .dark
//            withAnimation(.bouncy) {
//               circleOffset = CGSize(width: isDark ? 30 : 150, height: isDark ? -25 : -150)
//            }
        }

    }
}

//#Preview {
//    ChangeThemeView(scheme: .light)
//}

enum Theme: String, CaseIterable {
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    func color(_ scheme: ColorScheme) -> Color {
        switch self {
        case .systemDefault:
            return scheme == .dark ? .moon : .sun
        case .light:
            return .sun
        case .dark:
            return .moon
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .systemDefault:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}


//
//VStack(spacing: 16) {
//    
//    Text("Choose Theme")
//        .font(.title2.bold())
//        .padding(.top, 16)
//        
//    HStack(spacing: 0) {
//        ForEach(Theme.allCases, id: \.rawValue) { theme in
//            
//            VStack {
//                Image(theme.rawValue)
//                    .resizable()
//                    .frame(width: 50, height: 100)
//                    .aspectRatio(contentMode: .fill)
//                
//                VStack {
//                    Text(theme.rawValue)
//                        .padding(.vertical, 10)
//                        .frame(width: 100)
//                        .foregroundStyle(.primary)
//                        .background {
//                            ZStack {
//                                if userTheme == theme {
//                                    Capsule()
//                                        .fill(Color.primary.opacity(0.06))
//                                        .matchedGeometryEffect(id: "Active", in: animation)
//                                }
//                            }
//                            .animation(.snappy, value: userTheme)
//                        }
//                        
//                        .contentShape(.rect)
//                        .onTapGesture {
//                            userTheme = theme
//                        }
//                }
//                .padding(3)
//                .background(Color.blue.opacity(0.04), in: .capsule)
//                .padding(.top, 20)
//            }
//
//        }
//    }
//    
//}


//
//VStack(spacing: 16) {
//    Circle()
//        .fill(userTheme.color(scheme).gradient)
//        .frame(width: 150, height: 150)
//        .mask {
//            Rectangle()
//                .overlay {
//                    Circle()
//                        .offset(circleOffset)
//                        .blendMode(.destinationOut)
//                }
//        }
//
//    Text("Choose Theme")
//        .font(.title2.bold())
//        .padding(.top, 16)
//
//    HStack(spacing: 0) {
//        ForEach(Theme.allCases, id: \.rawValue) { theme in
//            VStack {
//                Text(theme.rawValue)
//                    .padding(.vertical, 10)
//                    .frame(width: 100)
//                    .foregroundStyle(.primary)
//                    .background {
//                        ZStack {
//                            if userTheme == theme {
//                                Capsule()
//                                    .fill(Color(.systemBackground))
//                                    .matchedGeometryEffect(id: "Active", in: animation)
//                            }
//                        }
//                        .animation(.snappy, value: userTheme)
//                    }
//                    .contentShape(.rect)
//                    .onTapGesture {
//                        userTheme = theme
//                    }
//            }
//
//
//
//        }
//    }
//    .padding(3)
//    .background(Color.primary.opacity(0.06), in: .capsule)
//    .padding(.top, 20)
//}
