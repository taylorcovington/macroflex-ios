//
//  HapticFeedbacks.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import UIKit

struct HapticFeedbacks {
    
    // MARK: - Functions:
    
    /// Triggers after any successful action:
    static func success() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    /// Triggers when there is an error:
    static func error() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    /// Soft feedback that is usually used when deleting or hiding something within the app:
    static func soft() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }
    
    /// Triggers when the selection changes:
    static func selectionChanges() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
}
