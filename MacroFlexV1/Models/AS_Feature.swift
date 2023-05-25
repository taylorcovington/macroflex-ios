//
//  AS_Feature.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import Foundation

enum AS_Feature: Int {
    
    // MARK: - Cases:
    
    case first
    case second
    case third
    case fourth
  
    
    // MARK: - Computed properties:
    
    /// Identifier of the feature:
    var id: Int {
        rawValue
    }
    
    /// Title of the feature:
    var title: String {
        switch self {
        case .first: return "Track Daily Progress"
        case .second: return "Get Your Macros Right"
        case .third: return "Track Exercise Progression"
        case .fourth: return "See Overall Progress"
       
        }
    }
    
    /// Text of the feature:
    var text: String {
        switch self {
        case .first: return "See your daily health all in one place. Set goals, stick to them."
        case .second: return "Nutrition is 80%. MacroFlex helps you get this right so the rest falls into place."
        case .third: return "Track your exercise progress with analytics to see when to increase weight."
        case .fourth: return "MacroFlex gives you insight into your overall health progression."
      
        }
    }
    
    /// Color of the feature:
    var color: String {
        switch self {
        case .first: return Colors.mfBluePrimary
        case .second: return Colors.mfBluePrimary
        case .third: return Colors.mfBluePrimary
        case .fourth: return Colors.mfBluePrimary
       
        }
    }
    
    /// Icon of the feature:
    var icon: String {
        switch self {
        case .first: return Icons.rectangleStack
        case .second: return Icons.creditCard
        case .third: return Icons.bolt
        case .fourth: return Icons.lock
        
        }
    }
    
    /// Image for the second onboarding segment:

    /// Image for the eighth onboarding segment:
    var onboardingEightImage: String {
        switch self {
        case .first: return Images.onboardingOne
        case .second: return Images.onboardingTwo
        case .third: return Images.onboardingThree
        case .fourth: return Images.onboardingThree
     
        }
    }

    
    /// Title of the badge of the onboarding segment:
    var badgeTitle: String {
        switch self {
        case .first: return "Daily Progress"
        case .second: return "Macro Tracking"
        case .third: return "Exercise Tracking"
        case .fourth: return "Progress Analytics"
        }
    }
}

// MARK: - Identifiable:

extension AS_Feature: Identifiable {  }

// MARK: - CaseIterable:

extension AS_Feature: CaseIterable {  }

// MARK: - Hashable:

extension AS_Feature: Hashable {
    
    // MARK: - Functions:
    
    /// Hashes the values of the feature:
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(text)
        hasher.combine(color)
        hasher.combine(icon)
        hasher.combine(onboardingEightImage)
      
    }
}
