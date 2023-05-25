//
//  DashboardViewModel.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/11/23.
//

import Foundation
import HealthKit

final class DashboardViewModel: ObservableObject {
    var activity: Activity
    var healthStore: HealthStore = HealthStore()
    
    @Published var healthData = [HealthStat]()
    @Published var healthStatToday: Int = 0
    @Published var todaysWeight: Double = 0
    
    
    init(activity: Activity) {
       
        self.activity = activity
        print(activity.id)
        switch activity.id {
            case "stepCount":
                self.healthStore.requestHealthStat(by: activity.id) { hStats in
                    print("hstats: \(hStats)")
                    self.healthData = hStats
                }
                self.healthStore.requestHealthStatToday(by: activity.id) { hStat in
                    print("Today's health stat: \(hStat)")
                    self.healthStatToday = hStat

                }
            case "bodyMass":
                self.healthStore.requestBodyWeight() { hStats in
                    print("hstats: \(hStats)")
                    self.healthData = hStats
                }
                self.healthStore.requestBodyWeightToday() { hStat in
                    print("Today's body weight: \(hStat)")
                    self.todaysWeight = hStat

            }
           default:
            self.healthStore.requestHealthStat(by: activity.id) { hStats in
                print("hstats: \(hStats)")
                self.healthData = hStats
            }
        }
        
        
//        self.healthStore.requestHealthStatToday(by: activity.id) { hStat in
//            print("Today's health stat: \(hStat)")
//            self.healthStatToday = hStat
//
//        }
    }
    
    let measurementFormatter = MeasurementFormatter()
    
    func value(from stat: HKQuantity?) -> (value: Int, desc: String) {
        guard let stat = stat else { return (0, "") }
        
        measurementFormatter.unitStyle = .long
        
        if stat.is(compatibleWith: .kilocalorie()) {
            let value = stat.doubleValue(for: .kilocalorie())
            return (Int(value), stat.description)
        } else if stat.is(compatibleWith: .meter()) {
            let value = stat.doubleValue(for: .mile())
            let unit = Measurement(value: value, unit: UnitLength.miles)
            return (Int(value), measurementFormatter.string(from: unit))
        } else if stat.is(compatibleWith: .count()) {
            let value = stat.doubleValue(for: .count())
            return (Int(value), stat.description)
        } else if stat.is(compatibleWith: .minute()) {
            let value = stat.doubleValue(for: .minute())
            return (Int(value), stat.description)
        }
        
        return (0, "")



        
    }
//
//    func readStepsTakenToday() {
//        healthKitManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
//            if step != 0.0 {
//                DispatchQueue.main.async {
//                    self.userStepCount = String(format: "%.0f", step)
//                }
//            }
//        }
//    }
}
