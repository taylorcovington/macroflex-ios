//
//  DashboardViewModel.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/11/23.
//

import Foundation
import HealthKit

final class DashboardViewModel: ObservableObject {
    static let shared = DashboardViewModel()
    
    var healthStore: HealthStore = HealthStore()
    
    @Published var healthData = [HealthStat]()
    @Published var healthStatToday: Int = 0
    @Published var todaysWeight: Double = 0
    @Published var todaysSleep: Double = 0
    @Published var todaysWaterIntake: Double = 0
    @Published var todayExerciseTime: Double = 0
    private let tokenKey = "AuthToken"
    
    @Published var sleepStats: [HealthStat] = [] // Your array of HealthStat objects goes here
    
    
    func sendDataToServer(urlString: String, dataArray: [[String: Any]]) {
        guard let url = URL(string: "http://192.168.1.209:8080/api/\(urlString)") else {
            print("Invalid URL")
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: tokenKey) else {
            return
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dataArray)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
    }
    
    init() {
        
        fetchData()
    }
        
        func fetchData() {
            let activities = Activity.allActivities()
            
            for activity in activities {
                switch activity.id {
                case "stepCount":
                    self.healthStore.requestHealthStat(by: activity.id) { hStats in
                        print("hstats: \(hStats)")
                            self.healthData = hStats
                            
                            var stepCountDataArray: [[String: Any]] = []

                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd" // Choose an appropriate date format
                            
                            for healthStat in hStats {
                                let formattedDate = dateFormatter.string(from: healthStat.date)
                                let stepAmount = Int(healthStat.stat ?? 0)
                                let stepCountData: [String: Any] = ["step_amount": stepAmount, "date": formattedDate]
                                stepCountDataArray.append(stepCountData)
                            }
                            
                            self.sendDataToServer(urlString: "step_logs", dataArray: stepCountDataArray)
                    }
                    self.healthStore.requestHealthStatToday(by: activity.id) { hStat in
                        print("Today's health stat: \(hStat)")
                        self.healthStatToday = hStat
                        
                        
                    }
                case "bodyMass":
                    self.healthStore.requestBodyWeight() { hStats in
                        print("hstats: \(hStats)")
                        self.healthData = hStats
                        
                        var weightDataArray: [[String: Any]] = []

                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd" // Choose an appropriate date format
                        
                        for healthStat in hStats {
                            let formattedDate = dateFormatter.string(from: healthStat.date)
                            let weightAmount = healthStat.stat ?? 0
                            let roundedWeightAmount = (weightAmount * 10).rounded() / 10
                            let formattedWeightAmount = String(format: "%.1f", roundedWeightAmount)
                            let weightData: [String: Any] = ["weight": formattedWeightAmount, "date": formattedDate]
                            weightDataArray.append(weightData)
                        }
                        
                        self.sendDataToServer(urlString: "weight_logs", dataArray: weightDataArray)
                    
                        
                    }
                    self.healthStore.requestBodyWeightToday() { hStat in
                        print("Today's body weight: \(hStat)")
                        self.todaysWeight = hStat
//                        let weightData = ["weight": hStat, "date": self.getCurrentDate()] as [String : Any]
//                        self.sendDataToServer(urlString: "weight_logs", data: weightData)
                    }
                case "sleep":
                    self.healthStore.requestSleepData { sleepStats in
                        print("sleepStats: \(sleepStats)")
                        self.sleepStats = sleepStats // Assuming self.healthData is [HealthStat]
                        
                        let aggregatedData = aggregatedSleepDataForLast7Days(sleepStats: sleepStats)
                        
                        var sleepDataArray: [[String: Any]] = []

                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd" // Choose an appropriate date format
                        
                        
                        
                        for healthStat in sleepStats {
                            let formattedDate = dateFormatter.string(from: healthStat.date)
                            let sleepAmount = Int(healthStat.stat ?? 0)
                            let sleepData: [String: Any] = ["sleep_minutes": sleepAmount, "date": formattedDate]
                            sleepDataArray.append(sleepData)
                        }
                        
                        self.sendDataToServer(urlString: "sleep_logs", dataArray: sleepDataArray)
                    }

                    self.healthStore.requestSleepDataForLastNight { sleepDurationInMinutes in
                           DispatchQueue.main.async {
                               print("Sleep duration for today: \(sleepDurationInMinutes) minutes")
                               self.todaysSleep = sleepDurationInMinutes
//                               let sleepData = ["sleep_minutes": sleepDurationInMinutes, "date": self.getCurrentDate()] as [String : Any]
//                               self.sendDataToServer(urlString: "sleep_logs", data: sleepData)
                           }
                       }
                    
                case "waterIntake":
                    self.healthStore.requestWaterIntakeDataForToday { waterStats in
                        if let waterStat = waterStats.first {
                            DispatchQueue.main.async {
                                print("waterStat: \(waterStat)")
                                
                                self.todaysWaterIntake = waterStat.stat ?? 0
                            }
                        }
                    }
                case "exerciseTime":
                    self.healthStore.requestExerciseTimeForToday { exerciseTimeInMinutes in
                        DispatchQueue.main.async {
                            print("Exercise time for today: \(exerciseTimeInMinutes) minutes")
                            self.todayExerciseTime = exerciseTimeInMinutes
                        }
                    }
                
                default:
                    self.healthStore.requestHealthStat(by: activity.id) { hStats in
                        print("hstats: \(hStats)")
                        self.healthData = hStats
                    }
                }
            }
                
            }
        
    func formatTime(minutes: Double) -> String {
        let hours = Int(minutes) / 60
        let remainingMinutes = Int(minutes) % 60
        
        return "\(hours)h \(remainingMinutes)m"
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
    
    
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }

}

func aggregatedSleepDataForLast7Days(sleepStats: [HealthStat]) -> [SleepEntry] {
    // Filter sleep data for the last 7 days
    let last7Days = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    let filteredData = sleepStats.filter { $0.date >= last7Days }
    
    // Group the filtered data by date
    let groupedData = Dictionary(grouping: filteredData, by: { Calendar.current.startOfDay(for: $0.date) })
    
    // Calculate the total sleep duration for each date
    var aggregatedData: [SleepEntry] = []
    for (date, stats) in groupedData {
        let totalSleepDuration = stats.reduce(0) { $0 + ($1.stat ?? 0) }
        let entry = SleepEntry(date: date, totalSleepDuration: totalSleepDuration)
        aggregatedData.append(entry)
    }
    
    return aggregatedData
}
