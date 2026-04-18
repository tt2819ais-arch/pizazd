//
//  ContentView.swift
//  Void
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = VoidViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var systemColorScheme
    
    var body: some View {
        ZStack {
            // Background
            backgroundGradient
                .ignoresSafeArea()
            
            // Main Content
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 80)
                
                // Main Void Button
                VoidButton(
                    currentColor: $viewModel.currentColor,
                    onTap: {
                        viewModel.cycleColor()
                    }
                )
                .padding(.vertical, 60)
                
                Spacer()
                
                // Device Info Cards
                DeviceInfoCard(deviceInfo: viewModel.deviceInfo)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 50)
            }
            
            // Theme Toggle Button
            VStack {
                HStack {
                    Spacer()
                    ThemeToggleButton()
                        .environmentObject(themeManager)
                        .padding(.trailing, 24)
                        .padding(.top, 60)
                }
                Spacer()
            }
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.5), value: viewModel.currentColor)
        .animation(.spring(response: 0.5, dampingFraction: 0.85), value: themeManager.selectedScheme)
    }
    
    private var backgroundGradient: some View {
        let isLight = (themeManager.selectedScheme == .light) || 
                     (themeManager.selectedScheme == nil && systemColorScheme == .light)
        
        return Group {
            if isLight {
                Color.white
            } else {
                Color.black
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
}
