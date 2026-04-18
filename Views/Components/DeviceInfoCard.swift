//
//  DeviceInfoCard.swift
//  Void
//

import SwiftUI

struct DeviceInfoCard: View {
    let deviceInfo: DeviceInfo
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 16) {
            InfoRow(icon: "iphone.gen3", title: "Model", value: deviceInfo.model)
            InfoRow(icon: "gear.badge", title: "System", value: deviceInfo.systemVersion)
            InfoRow(icon: "square.resize", title: "Screen", value: deviceInfo.screenInfo)
            InfoRow(icon: "number.square", title: "Identifier", value: deviceInfo.identifier)
        }
        .padding(24)
        .modifier(GlassmorphicModifier(color: .white.opacity(0.05), intensity: .regular))
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.secondary)
                .frame(width: 28)
            
            // Title
            Text(title)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
                .frame(width: 90, alignment: .leading)
            
            Spacer()
            
            // Value
            Text(value)
                .font(.system(size: 15, weight: .semibold, design: .monospaced))
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .padding(.vertical, 4)
    }
}
