//
//  AddButton.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/27/23.
//

import SwiftUI
import SwiftfulRouting

struct AddButton: View {
    let router: AnyRouter
   
    var body: some View {
        Button(action: {
            router.showModal(transition: .move(edge: .bottom), animation: .easeInOut, alignment: .bottom, backgroundColor: Color.black.opacity(0.35), useDeviceBounds: true) {
                AddView(router: router)
            }
        }, label: {
            Image(systemName: "plus.circle.fill").renderingMode(.template).resizable().frame(width: 50, height: 50, alignment: .center)
        })
    }
}

//struct AddButton_Previews: PreviewProvider {
//    static var previews: some View {
//        AddButton(showAddButton: )
//    }
//}
