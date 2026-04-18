//
//  ThemeManager.swift
//  Void
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var selectedScheme: ColorScheme?
    
    var isLightMode: Bool {
        selectedScheme == .light
    }
    
    init() {
        // Start with system default (nil means system)
        self.selectedScheme = nil
    }
    
    func toggleTheme() {
        switch selectedScheme {
        case .none:
            selectedScheme = .dark
        case .light:
            selectedScheme = .dark
        case .dark:
            selectedScheme = .light
        }
    }
}
