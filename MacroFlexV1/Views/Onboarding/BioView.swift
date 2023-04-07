//
//  BioView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/4/23.
//

import SwiftUI
import SwiftfulRouting


struct BioView: View {
    let router: AnyRouter
    @State private var name: String = ""
    @State private var gender: String = ""
    @State private var weight: CGFloat = 0
    @State private var dob: Date = Date()
    var genderOptions = ["Male", "Female"]
    
    @AppStorage("name") var currentUsersName: String?
    @AppStorage("gender") var currentUsersGender: String?
//    @AppStorage("age") var currentUsersDOB: Date?
    
    
    var body: some View {
            VStack {
                HStack{
                    Text("Tell us about yourself")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                VStack(spacing: 20) {
                    CustomTextField(text: $name, titleText: "What is your name?", placeholder: Text("John Doe"))
                       
                    
                    CustomSegmentedPicker(selection: $gender, title: "What is your gender?", optionsArray: genderOptions)
                    
                    CustomWeightPicker(weight: $weight)
                    
                    CustomDatePicker(router: router, date: dob)
                        .padding(.leading)
                  
                }
                .padding(.top, 30)
                   
                
                Spacer()
                Button("Next") {
                    router.showScreen(.push) { router in
                        GoalsView(router: router)
                    }
                }
            }
            .navigationTitle("About you")
    }
}

struct BioView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            BioView(router: router)
        }
    }
}
