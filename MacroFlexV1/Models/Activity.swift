import Foundation

struct Activity: Identifiable {
    var id: String
    var name: String
    var image: String
    
    static func allActivities() -> [Activity] {
        return [
            Activity(id: "stepCount", name: "Steps", image: "runningshoe"),
            Activity(id: "bodyMass", name: "Weight", image: "weightscale"),
            Activity(id: "sleep", name: "Sleep", image: "moon"),
            Activity(id: "waterIntake", name: "Water Intake", image: "waterdrop"),
            Activity(id: "exerciseTime", name: "Exercise Time", image: "dumbbell"),
        ]
    }
}

