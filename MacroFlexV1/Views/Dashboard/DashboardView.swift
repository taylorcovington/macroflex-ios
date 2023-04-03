//
//  DashboardView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/31/23.
//

import SwiftUI
import SwiftfulRouting

struct DashboardView: View {
    let router: AnyRouter
    var body: some View {
        VStack {
            Image("weightscale")
                .resizable()
                .frame(width: 75, height: 75)
             
            Text("2,343")
                .font(.system(size: 24, weight: .bold, design: .rounded))
            Text("Weight")
                .font(.system(size: 12, weight: .regular, design: .rounded))
                .foregroundColor(.secondary)
            
        }
        .onTapGesture {
            router.showScreen(.push) { router in
                StepsView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(25)
        .padding(10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            DashboardView(router: router)
        }
    }
}
