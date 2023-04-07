//
//  TrainingExperienceView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/5/23.
//

import SwiftUI

struct TrainingExperienceView: View {
//    @State var isSelected: Bool
//    private var trainingExperienceOptions = []
    var body: some View {
        VStack{
            VStack(alignment: .leading) {
                Text("Beginner")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding(.bottom, 2)
                Text("Lifting for the past year or less")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
                
            }
            .frame(width: 350, height: 70)
            .cornerRadius(30)
            .padding(10)
            .padding(.leading, -50)
            .overlay(
               RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 1)
//               TODO: If selected, .gray + lineWidth: 4
            )
            
           
        }
        .navigationTitle("What is your experience level with lifting?")
        
    }
}

struct TrainingExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingExperienceView()
    }
}
