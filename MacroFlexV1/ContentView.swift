//
//  ContentView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/31/23.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    var body: some View {
        RouterView(addNavigationView: true) { router in
            CustomTabView(router: router)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
