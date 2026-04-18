//
//  ThemeToggleButton.swift
//  Void
//

import SwiftUI

struct ThemeToggleButton: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            HapticManager.shared.impact(style: .light)
            withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                themeManager.toggleTheme()
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    isPressed = false
                }
            }
        }) {
            ZStack {
                // Glass background
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                    .frame(width: 50, height: 50)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                
                // Icon
                Image(systemName: themeManager.isLightMode ? "moon.fill" : "sun.max.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                themeManager.isLightMode ? Color.purple : Color.orange,
                                themeManager.isLightMode ? Color.blue : Color.yellow
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .rotationEffect(.degrees(themeManager.isLightMode ? 0 : 180))
            }
            .scaleEffect(isPressed ? 0.88 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
