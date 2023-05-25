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
    @State private var weight: String = ""
    @State private var dob: Date = Date()
    @State private var weightType: String = ""
    var genderOptions = ["Male", "Female"]
    
    @AppStorage("name") var currentUsersName: String?
    @AppStorage("gender") var currentUsersGender: String?
    @AppStorage("starting_weight") var usersStartingWeight: String?
    @AppStorage("dob") var currentUsersDOB: String?
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
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
                        
                        CustomWeightPickerV1(weight: $weight, weightType: $weightType)
                            .padding()
                        //                    CustomWeightPicker(weight: $weight)
                        
                        CustomDatePicker(router: router, date: dob)
                            .padding()
                      
                    }
                    .padding(.top, 30)
                       
                    
                    Spacer()
                    HStack {
                        ButtonView(title: "Next") {
                            currentUsersName = name
                            currentUsersGender = gender
                            usersStartingWeight =  weight
                            currentUsersDOB = "\(dob)"
                            
                            
                            router.showScreen(.push) { router in
                                GoalsView(router: router)
                            }
                        }
                    }
                    .padding()
                }
            .navigationTitle("About you")
            .onAppear {
                
                name = currentUsersName ?? ""
                gender = currentUsersGender ?? ""
                weight = usersStartingWeight ?? ""
//                dob = Date(currentUsersDOB) ?? Date()
            }
        }
    }
}

struct BioView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            BioView(router: router)
        }
    }
}
