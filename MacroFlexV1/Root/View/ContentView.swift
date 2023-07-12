//
//  ContentView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/31/23.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
        @AppStorage("onboarding") var isOnboarding: Bool = true
        @State private var isSplashScreen = true
        @State private var isLogin = true
    
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
        RouterView(addNavigationView: true) { router in
            if authViewModel.isAuthenticated {
                if isOnboarding {
                    WelcomeView(router: router)
                } else {
                    CustomTabView(router: router, authViewModel: AuthViewModel())
                }
            } else {
                LoginFiveView(router: router,authViewModel: authViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//struct ContentView: View {
//    @AppStorage("onboarding") var isOnboarding: Bool = true
//    @State private var isSplashScreen = true
//    @State private var isLogin = true
//    @State private var isAuthenticated = false
//
//    @EnvironmentObject var viewModel: AuthViewModel
//
//    var body: some View {
//        RouterView(addNavigationView: true) { router in
//            if !isSplashScreen {
//                if $viewModel.token.wrappedValue != nil {
//                    LoginFiveView(router: router)
//                } else {
//                    if isOnboarding {
//                        WelcomeView(router: router)
//                    } else {
//                        CustomTabView(router: router)
//                    }
//                }
//
//            } else {
//                SplashscreenView(isSplashScreen: $isSplashScreen)
//            }
//        }
//
//    }
//
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
