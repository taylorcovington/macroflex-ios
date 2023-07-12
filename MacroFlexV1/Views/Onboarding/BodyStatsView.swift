//
//  BodyStatsView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/3/23.
//

import SwiftUI
import SwiftfulRouting

struct BodyStatsView: View {
    let router: AnyRouter
    var body: some View {
        VStack {
            Text("Body stats View")
            Button("Next") {
                router.showScreen(.push) { router in
                    MacroCalculationView(router: router, authViewModel: AuthViewModel())
                }
            }
        }
        .navigationTitle("Step 2")
    }
}

struct BodyStatsView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            BodyStatsView(router: router)
        }
    }
}
