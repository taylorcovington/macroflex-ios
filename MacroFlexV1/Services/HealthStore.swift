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
    @Published var todaysSleep: Double = 0.0
    
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore =  HKHealthStore()
        }
    }
    
    func requestAuth() {
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater)!
        let allTypesToShare = Set([
            HKObjectType.workoutType(),
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
//            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
            sleepType, // Sleep
            waterType // Water intake
        ])
        let allTypesToRead = Set([
            HKObjectType.workoutType(),
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
            sleepType, // Sleep
            waterType // Water intake
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
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
                
        let bodyMassType = HKSampleType.quantityType(forIdentifier: .bodyMass)!
        let query = HKSampleQuery(sampleType: bodyMassType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
            if let error = error {
                print("Error querying body mass: \(error.localizedDescription)")
            } else if let samples = results as? [HKQuantitySample] {
                for sample in samples {
                    let bodyMass = sample.quantity.doubleValue(for: HKUnit.pound())
                    let stat = HealthStat(stat: bodyMass, date: sample.startDate)
                    healthStats.append(stat)
                }
                completion(healthStats)
            }
        }
        
        store.execute(query)
    }
    
    
//    MARK: Sleep
    func requestSleepData(completion: @escaping ([HealthStat]) -> Void) {
        guard let store = healthStore,
              let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        
        let asleepValue = HKCategoryValueSleepAnalysis.asleepUnspecified.rawValue
        
        var healthStats = [HealthStat]()
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
            if let error = error {
                print("Error querying sleep data: \(error.localizedDescription)")
            } else if let samples = results as? [HKCategorySample] {
                for sample in samples {
                    // Check if the sample's value is equal to the asleep value
                    if sample.value == asleepValue {
                        let sleepDuration = sample.endDate.timeIntervalSince(sample.startDate)
                        let stat = HealthStat(stat: sleepDuration, date: sample.startDate)
                        healthStats.append(stat)
                    }
                }
                completion(healthStats)
            }
        }
        
        store.execute(query)
    }
    
    func requestSleepDataForLastNight(completion: @escaping (Double) -> Void) {
        let healthStore = HKHealthStore()
         let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
         let calendar = Calendar.current
         let now = Date()
         let endOfDay = calendar.startOfDay(for: now)
         let startOfDay = calendar.date(byAdding: .day, value: 0, to: endOfDay)! // Same day, 0 means today
         
         // Predicate to filter for HKCategoryValueSleepAnalysis.asleepUnspecified
         let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
         let categoryValue = HKCategoryValueSleepAnalysis.asleepUnspecified.rawValue
         let categoryPredicate = HKQuery.predicateForCategorySamples(with: .equalTo, value: categoryValue)
         let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, categoryPredicate])
         
         let query = HKSampleQuery(sampleType: sleepType, predicate: combinedPredicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
             guard let samples = samples, error == nil else {
                 print("Error querying sleep data: \(error?.localizedDescription ?? "Unknown Error")")
                 return
             }
             
             var totalSleepDuration: TimeInterval = 0
             
             for sample in samples {
                 if let sample = sample as? HKCategorySample {
                     totalSleepDuration += sample.endDate.timeIntervalSince(sample.startDate)
                 }
             }
             
             let sleepDurationInMinutes = totalSleepDuration / 60
             print("SLEEP DURATION >>>> \(sleepDurationInMinutes)")
             DispatchQueue.main.async {
                 self.todaysSleep = sleepDurationInMinutes
             }
         }
         
         healthStore.execute(query)
     }





    func requestWaterIntakeData(completion: @escaping ([HealthStat]) -> Void) {
        guard let store = healthStore,
              let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater) else {
            return
        }
        
        var healthStats = [HealthStat]()
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: waterType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
            if let error = error {
                print("Error querying water intake data: \(error.localizedDescription)")
            } else if let samples = results as? [HKQuantitySample] {
                for sample in samples {
                    let waterIntake = sample.quantity.doubleValue(for: HKUnit.fluidOunceUS())
                    let stat = HealthStat(stat: waterIntake, date: sample.startDate)
                    healthStats.append(stat)
                }
                completion(healthStats)
            }
        }
        
        store.execute(query)
    }
    
    func requestWaterIntakeDataForToday(completion: @escaping ([HealthStat]) -> Void) {
        guard let store = healthStore,
              let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater) else {
            return
        }
        
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: waterType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
            if let error = error {
                print("Error querying water intake data for today: \(error.localizedDescription)")
            } else if let samples = results as? [HKQuantitySample] {
                var totalWaterIntakeInFluidOunces: Double = 0.0
                
                for sample in samples {
                    totalWaterIntakeInFluidOunces += sample.quantity.doubleValue(for: HKUnit.fluidOunceUS())
                }
                
                // Create a HealthStat object to store the water intake data for today
                let waterIntakeStat = HealthStat(stat: totalWaterIntakeInFluidOunces, date: startDate)
                
                // Call the completion handler with the water intake data for today
                completion([waterIntakeStat])
            } else {
                // If no water intake data is available for today, return an empty array
                completion([])
            }
        }
        
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
//                print("BodyMass >>>>> \(weight)")
                completion(weight)
               }
        }

        store.execute(query)
    }
    
    func requestExerciseTimeForToday(completion: @escaping (Double) -> Void) {
        guard let store = healthStore,
              let exerciseTimeType = HKObjectType.quantityType(forIdentifier: .appleExerciseTime) else {
            return
        }

        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = Date()

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: exerciseTimeType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            if let error = error {
                print("Error querying exercise time for today: \(error.localizedDescription)")
                completion(0)
            } else if let result = result, let exerciseTime = result.sumQuantity() {
                let seconds = exerciseTime.doubleValue(for: HKUnit.second())
                let minutes = seconds / 60.0
                completion(minutes)
            } else {
                // If no exercise time data is available for today, return 0 minutes
                completion(0)
            }
        }

        store.execute(query)
    }


    
//    MARK: Get steps
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
         
 //        print("average: ", averagec(numbers: countArr))
         
         guard let query = query else {
             print("there was no query, returning")
             return
         }
         
         store.execute(query)
         
     }
     
//    MARK: Get steps
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


