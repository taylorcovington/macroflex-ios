//
//  MacroFlexV1App.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/31/23.
//

import SwiftUI

@main
struct MacroFlexV1App: App {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.black
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
