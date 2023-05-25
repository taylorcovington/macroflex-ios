//
//  Activities.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/11/23.
//

import Foundation

struct Activity: Identifiable {
    var id: String
    var name: String
    var image: String
    
    static func allActivities() -> [Activity] {
        return [
        Activity(id: "stepCount", name: "Steps", image: "runningshoe"),
        Activity(id: "bodyMass", name: "Weight", image: "weightscale"),
//        Activity(id: "stepCount", name: "Steps", image: "runningshoe"),
        Activity(id: "appleExerciseTime", name: "Exercise Time", image: "stopwatch"),
        ]
    }
}
