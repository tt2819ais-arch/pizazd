//
//  VoidViewModel.swift
//  Void
//

import SwiftUI
import Combine

class VoidViewModel: ObservableObject {
    @Published var currentColor: Color
    @Published var deviceInfo: DeviceInfo
    
    private var currentColorIndex = 0
    private let hapticManager = HapticManager.shared
    
    init() {
        self.currentColor = ColorPalette.premiumColors[0]
        self.deviceInfo = DeviceInfo.current
    }
    
    func cycleColor() {
        hapticManager.impact(style: .soft)
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 0.3)) {
            currentColorIndex = (currentColorIndex + 1) % ColorPalette.premiumColors.count
            currentColor = ColorPalette.premiumColors[currentColorIndex]
        }
        
        // Ripple effect delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.hapticManager.impact(style: .rigid)
        }
    }
}
