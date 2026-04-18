//
//  VoidButton.swift
//  Void
//

import SwiftUI

struct VoidButton: View {
    @Binding var currentColor: Color
    let onTap: () -> Void
    
    @State private var isPressed = false
    @State private var rippleCount = 0
    
    private let buttonSize: CGFloat = 240
    
    var body: some View {
        ZStack {
            // Outer glow
            Circle()
                .fill(
                    currentColor.opacity(0.3)
                )
                .frame(width: buttonSize + 40, height: buttonSize + 40)
                .blur(radius: 30)
                .scaleEffect(isPressed ? 0.95 : 1.0)
            
            // Middle glow
            Circle()
                .fill(
                    currentColor.opacity(0.2)
                )
                .frame(width: buttonSize + 20, height: buttonSize + 20)
                .blur(radius: 20)
            
            // Main button with glassmorphism
            ZStack {
                // Background circle
                Circle()
                    .fill(currentColor.opacity(0.15))
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.5),
                                        Color.white.opacity(0.1)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                    )
                
                // Glass material overlay
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        currentColor.opacity(0.3),
                                        currentColor.opacity(0.1),
                                        Color.clear
                                    ],
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: buttonSize / 2
                                )
                            )
                    )
                
                // Inner subtle glow
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.white.opacity(0.4),
                                Color.clear
                            ],
                            center: .topLeading,
                            startRadius: 0,
                            endRadius: buttonSize / 2
                        )
                    )
                    .blur(radius: 10)
                    .blendMode(.overlay)
                
                // Ripple effect
                if rippleCount > 0 {
                    ForEach(0..<rippleCount, id: \.self) { index in
                        RippleEffect(color: currentColor)
                            .id(index)
                    }
                }
                
                // Text
                Text("Void")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .tracking(-2)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                currentColor.opacity(0.9),
                                currentColor.opacity(0.6)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: currentColor.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .frame(width: buttonSize, height: buttonSize)
            .scaleEffect(isPressed ? 0.92 : 1.0)
            .shadow(color: currentColor.opacity(0.4), radius: 25, x: 0, y: 15)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            
            onTap()
            rippleCount += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    isPressed = false
                }
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.75), value: currentColor)
    }
}
