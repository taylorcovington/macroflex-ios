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
    var experienceOptions: [String] = ["Beginner", "Intermediate", "Expert"]
    var fitnessGoalOptions: [String] = ["Lose Weight", "Maintain", "Lean Bulk"]
    
    var body: some View {
            VStack(spacing: 20) {
                
                CustomSegmentedPicker(selection: $experience, title: "What is your lifting experience?", optionsArray: experienceOptions)
                
                CustomSegmentedPicker(selection: $fitnessGoal, title: "What is your current lifting goal?", optionsArray: fitnessGoalOptions)
                
                Spacer()
                Button("Next") {
                    router.showScreen(.push) { router in
                        MacroCalculationView(router: router)
                    }
                }
            }
            .navigationTitle("Your Goals")
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            GoalsView(router: router)
        }
    }
}
