//
//  GoalsView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/3/23.
//

import SwiftUI
import SwiftfulRouting

struct WelcomeView: View {
    let router: AnyRouter
    var body: some View {
            VStack {
                Text("Let's get this party started 🥳")
                Button("Next") {
                    router.showScreen(.fullScreenCover) { router in
                        BioView(router: router)
                    }
                }
            }
            .navigationTitle("Welcome")
    }
}

struct ConnectView: View {
    let router: AnyRouter
    var body: some View {
            VStack {
                Text("Let's get to know eachother")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
                Spacer()
                Button("Next") {
                    router.showScreen(.push) { router in
                        BioView(router: router)
                    }
                }
            }
            .navigationTitle("Sync your data")
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            WelcomeView(router: router)
        }
    }
}
