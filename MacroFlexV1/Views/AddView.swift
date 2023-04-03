//
//  AddView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/31/23.
//

import SwiftUI
import SwiftfulRouting

struct AddView: View {
    let router: AnyRouter
    
    var body: some View {
        VStack {
            Text("Add View")
                
        }
        .frame(maxWidth: .infinity)
        .frame(height:  350)
        .background(Color.cyan)
        .cornerRadius(30)
        .onTapGesture{
            router.dismissModal()
        }
        
    }
        
}

//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddView()
//    }
//}
