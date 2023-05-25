//
//  HealthStore.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/11/23.
//

import Foundation
import HealthKit
import Charts

class HealthStore {
    
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore =  HKHealthStore()
        }
    }
    
    func requestAuth() {
//        let stepCount = HKQuantityType.quantityType(forIdentifier: .stepCount)
//        let weight = HKQuantityType.quantityType(forIdentifier: .bodyMass)
//        let exerciseTime = HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!
        let allTypesToShare = Set([HKObjectType.workoutType(),
                            HKObjectType.quantityType(forIdentifier: .stepCount)!,
                            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
//                            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
                           ])
        
        let allTypesToRead = Set([HKObjectType.workoutType(),
                                 HKObjectType.quantityType(forIdentifier: .stepCount)!,
                                 HKObjectType.quantityType(forIdentifier: .bodyMass)!,
                                 HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
                                ])

     

        healthStore?.requestAuthorization(toShare: allTypesToShare, read: allTypesToRead) { (success, error) in
            if let error = error {
                print("Not authorized to use HealthKit >> \(error)")
            }
            else if success {
                print("Request Granted")
                
            }
        }
    }
//
//    func getBodyMassData() {
//        let bodyMassType = HKSampleType.quantityType(forIdentifier: .bodyMass)!
//        let query = HKSampleQuery(sampleType: bodyMassType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
//            if let error = error {
//                print("Error querying body mass: \(error.localizedDescription)")
//            } else if let samples = results as? [HKQuantitySample] {
//                for sample in samples {
//                    let bodyMass = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
//                    print("Body mass: \(bodyMass) kg")
//                }
//            }
//        }
//        healthStore.execute(query)
//    }
    
    
    func requestBodyWeight(completion: @escaping ([HealthStat]) -> Void) {
        guard let store = healthStore else {
            return
        }
        
        var healthStats = [HealthStat]()
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let endDate = Date()
        let anchorDate = Date.firstDayOfWeek()
        let dailyComponent = DateComponents(day: 1)
        
//        var countArr: [Double] = []
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
                
        let bodyMassType = HKSampleType.quantityType(forIdentifier: .bodyMass)!
          let query = HKSampleQuery(sampleType: bodyMassType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
              if let error = error {
                  print("Error querying body mass: \(error.localizedDescription)")
              } else if let samples = results as? [HKQuantitySample] {
                  for sample in samples {
                      
                      let bodyMass = sample.quantity.doubleValue(for: HKUnit.pound())
                      print("Body mass: \(bodyMass) lbs, date: \(sample.startDate.displayFormat)")
//                      if bodyMass == nil { return }
                      let stat = HealthStat(stat: bodyMass, date: sample.startDate)
                      
                      healthStats.append(stat)
                  }
                  
//                  healthStats.append(HealthStat(stat: 158.6, date: Date(timeInterval: 2023-04-08, since: 22,:40:46 +0000)))
                  completion(healthStats)
              }
          }
        
//        guard let query = query else {
//            print("there was no query, returning")
//            return
//        }
        store.execute(query)
    }
    
    func requestBodyWeightToday(completion: @escaping (Double) -> Void) {
        
        guard let store = healthStore else {
            return
        }
       
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = Date()
        
//        var countArr: [Double] = []
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
                
        let bodyMassType = HKSampleType.quantityType(forIdentifier: .bodyMass)!

        let query = HKStatisticsQuery(quantityType: bodyMassType, quantitySamplePredicate: predicate, options: .mostRecent) { (query, result, error) in
            guard let result = result else {
                   // Handle error
                   return
               }
            
//            if let res = result as? HKStatistics {
//
//                let bodyMass = res.quantity.doubleValue(for: HKUnit.pound())
//             print("BodyMass >>>>> \(bodyMass)")
//                completion(bodyMass)
//            }
            if let latestWeightSample = result.mostRecentQuantity() {
                   let weight = latestWeightSample.doubleValue(for: HKUnit.pound())
                   // Do something with the weight, e.g. update UI
                print("BodyMass >>>>> \(weight)")
                completion(weight)
               }
        }

        store.execute(query)
    }

    
    func requestHealthStat(by category: String, completion: @escaping ([HealthStat]) -> Void) {
        guard let store = healthStore, let type = HKObjectType.quantityType(forIdentifier: typeByCategory(category: category)) else {
            return
        }
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let endDate = Date()
        let anchorDate = Date.firstDayOfWeek()
        let dailyComponent = DateComponents(day: 1)
        
        var healthStats = [HealthStat]()
        
        var countArr: [Double] = []
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)

        query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: optionByCategory(category: category), anchorDate: anchorDate, intervalComponents: dailyComponent)
        
        query?.initialResultsHandler = { query, statistics, error in
            if (error != nil) { print("there was an error during query: \(String(describing: error))") }
            statistics?.enumerateStatistics(from: startDate, to: endDate, with: { stats, _ in
//                var statItem: Double = 0
                let statItem = (stats.sumQuantity()?.doubleValue(for: .count()))
//                countArr.append(statItem!)
                
                let stat = HealthStat(stat: statItem, date: stats.startDate)
                healthStats.append(stat)
            })
            completion(healthStats)
        }
        
        print("average: ", averagec(numbers: countArr))
        
        guard let query = query else {
            print("there was no query, returning")
            return
        }
        
        store.execute(query)
        
    }
    
    func requestHealthStatToday(by category: String,completion: @escaping (Int) -> Void) {
        
        guard let store = healthStore, let type = HKObjectType.quantityType(forIdentifier: typeByCategory(category: category)) else {
            print("returning with NOTHING")
            return
        }
        
       
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                // Query failed
                print("query failed: \(error)")
                return
            }
            
            let todayStat = Int(sum.doubleValue(for: HKUnit.count()))
            completion(todayStat)
           
        }

        store.execute(query)
    }
    
    func averagec(numbers:[Double]) -> Double {
        return (Double(numbers.reduce(0,+))/Double(numbers.count)).rounded(.towardZero)
    }
    
    private func typeByCategory(category: String) -> HKQuantityTypeIdentifier {
        switch category {
        case "stepCount":
            return .stepCount
        case "bodyMass":
            return .bodyMass
        case "appleExerciseTime":
            return .appleExerciseTime
        default:
            return .stepCount
        }
    }
    private func optionByCategory(category: String) -> HKStatisticsOptions {
        switch category {
        case "stepCount":
            return .cumulativeSum
        case "bodyMass":
            return .mostRecent
//        case "appleExerciseTime":
//            return .appleExerciseTime
        default:
            return .cumulativeSum
        }
    }
}

extension Date {
    var displayFormat: String {
        self.formatted(date: .abbreviated, time: .omitted)
    }
    static func firstDayOfWeek() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()
    }
}


