//
//  ContentView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/31/23.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
//    var isOnboarding: Bool = true
    @AppStorage("onboarding") var isOnboarding: Bool = true
    @State private var isSplashScreen = true
    
    var body: some View {
        RouterView(addNavigationView: true) { router in
            if !isSplashScreen {
                if isOnboarding {
                    WelcomeView(router: router)
                } else {
                    CustomTabView(router: router)
                }
            } else {
                SplashscreenView(isSplashScreen: $isSplashScreen)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
