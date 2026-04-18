//
//  DeviceInfo.swift
//  Void
//

import UIKit
import SwiftUI

struct DeviceInfo {
    let model: String
    let systemVersion: String
    let screenInfo: String
    let identifier: String
    
    static var current: DeviceInfo {
        let device = UIDevice.current
        let screen = UIScreen.main
        
        let modelName = getDeviceModel()
        let systemVersion = "iOS \(device.systemVersion)"
        
        let width = Int(screen.bounds.width * screen.scale)
        let height = Int(screen.bounds.height * screen.scale)
        let diagonal = String(format: "%.1f\"", getScreenDiagonal())
        let screenInfo = "\(diagonal) • \(width)×\(height)"
        
        let identifier = getDeviceIdentifier()
        
        return DeviceInfo(
            model: modelName,
            systemVersion: systemVersion,
            screenInfo: screenInfo,
            identifier: identifier
        )
    }
    
    private static func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        // Map to human-readable names
        let modelMap: [String: String] = [
            "iPhone14,2": "iPhone 13 Pro",
            "iPhone14,3": "iPhone 13 Pro Max",
            "iPhone14,4": "iPhone 13 mini",
            "iPhone14,5": "iPhone 13",
            "iPhone14,6": "iPhone SE (3rd gen)",
            "iPhone14,7": "iPhone 14",
            "iPhone14,8": "iPhone 14 Plus",
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone15,4": "iPhone 15",
            "iPhone15,5": "iPhone 15 Plus",
            "iPhone16,1": "iPhone 15 Pro",
            "iPhone16,2": "iPhone 15 Pro Max",
            "arm64": "Simulator"
        ]
        
        return modelMap[identifier] ?? identifier
    }
    
    private static func getScreenDiagonal() -> Double {
        let screen = UIScreen.main
        let width = screen.bounds.width
        let height = screen.bounds.height
        let diagonal = sqrt(pow(width, 2) + pow(height, 2))
        
        // Convert points to inches (assuming 163 PPI for non-retina)
        return Double(diagonal) / 163.0
    }
    
    private static func getDeviceIdentifier() -> String {
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? "Unknown"
        let prefix = uuid.prefix(8)
        return String(prefix).uppercased()
    }
}
