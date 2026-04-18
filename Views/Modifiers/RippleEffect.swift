//
//  RippleEffect.swift
//  Void
//

import SwiftUI

struct RippleEffect: View {
    let color: Color
    @State private var animate = false
    
    var body: some View {
        Circle()
            .stroke(color.opacity(0.5), lineWidth: 3)
            .scaleEffect(animate ? 1.3 : 0.8)
            .opacity(animate ? 0 : 1)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    animate = true
                }
            }
    }
}
