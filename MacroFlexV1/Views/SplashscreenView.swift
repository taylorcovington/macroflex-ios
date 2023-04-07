//
//  SplashscreenView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/31/23.
//

import SwiftUI

struct SplashscreenView: View {
    @Binding var isSplashScreen: Bool
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        ZStack {
            Color(Colors.mfBluePrimary)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Image("whitefulllogo")
                        .resizable()
                        .frame(height: 175)
                        .padding()
                }
                .scaleEffect()
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isSplashScreen = false
                    }
                }
            }
            
        }
    }
}

struct SplashscreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashscreenView(isSplashScreen: .constant(true))
    }
}
