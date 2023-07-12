//
//  AccountView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        Text("Account View")
        Button("Logout") {
            authViewModel.logout()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(authViewModel: AuthViewModel())
    }
}
