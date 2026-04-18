//
//  GlassmorphicModifier.swift
//  Void
//

import SwiftUI

enum GlassIntensity {
    case ultraThin
    case thin
    case regular
    
    var material: Material {
        switch self {
        case .ultraThin: return .ultraThinMaterial
        case .thin: return .thinMaterial
        case .regular: return .regularMaterial
        }
    }
}

struct GlassmorphicModifier: ViewModifier {
    let color: Color
    let intensity: GlassIntensity
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    // Base color layer
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(color)
                    
                    // Glass material
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(intensity.material)
                    
                    // Inner glow
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(colorScheme == .dark ? 0.15 : 0.4),
                                    Color.clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .blur(radius: 3)
                    
                    // Border
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(colorScheme == .dark ? 0.3 : 0.6),
                                    Color.white.opacity(colorScheme == .dark ? 0.1 : 0.2)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )
            .shadow(color: .black.opacity(colorScheme == .dark ? 0.3 : 0.1), radius: 20, x: 0, y: 10)
            .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 5, x: 0, y: 2)
    }
}
