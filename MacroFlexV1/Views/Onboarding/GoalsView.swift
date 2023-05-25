//
//  GoalsView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import SwiftUI
import SwiftfulRouting

struct GoalsView: View {
    let router: AnyRouter
    
    @State var experience: String = ""
    @State var fitnessGoal: String = ""
    
    @AppStorage("experience") var currentExperience: String?
    @AppStorage("fitness_goal") var currentFitnessGoal: String?
    
    var experienceOptions: [String] = ["Beginner", "Intermediate", "Expert"]
    var fitnessGoalOptions: [String] = ["Lose Weight", "Maintain", "Lean Bulk"]
    
    var body: some View {
            VStack(spacing: 20) {
                
                CustomSegmentedPicker(selection: $experience, title: "What is your lifting experience?", optionsArray: experienceOptions)
                
                CustomSegmentedPicker(selection: $fitnessGoal, title: "What is your current lifting goal?", optionsArray: fitnessGoalOptions)
                
//                TODO: What is your goal weight?
                
//                TODO: What is your goal step count?
                
//                TODO: What is your goal water intake?
                
            
                
                Spacer()
               
                HStack {
                    ButtonView(title: "Next") {
                        currentExperience = experience
                        currentFitnessGoal = fitnessGoal
                        
                        router.showScreen(.fullScreenCover) { router in
                            MacroCalculationView(router: router)
//                            DashboardView(router: router)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Your Goals")
            .onAppear {
                
                experience = currentExperience ?? ""
                fitnessGoal = currentFitnessGoal ?? ""
//                dob = Date(currentUsersDOB) ?? Date()
            }
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            GoalsView(router: router)
        }
    }
}
