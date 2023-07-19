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
    private let tokenKey = "AuthToken"
    
    
    func sendDataToServer(urlString: String, data: [String: Any]) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: tokenKey) else {
            return
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: data)
        
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
                    }
                    self.healthStore.requestHealthStatToday(by: activity.id) { hStat in
                        print("Today's health stat: \(hStat)")
                        self.healthStatToday = hStat
                        let stepCountData = ["step_amount": hStat, "date": self.getCurrentDate()] as [String : Any]
                        self.sendDataToServer(urlString: "http://192.168.1.209:8080/api/step_logs", data: stepCountData)
                        
                    }
                case "bodyMass":
                    self.healthStore.requestBodyWeight() { hStats in
                        print("hstats: \(hStats)")
                        self.healthData = hStats
                    }
                    self.healthStore.requestBodyWeightToday() { hStat in
                        print("Today's body weight: \(hStat)")
                        self.todaysWeight = hStat
                        let weightData = ["weight": hStat, "date": self.getCurrentDate()] as [String : Any]
                        self.sendDataToServer(urlString: "http://192.168.1.209:8080/api/weight_logs", data: weightData)
                    }
                default:
                    self.healthStore.requestHealthStat(by: activity.id) { hStats in
                        print("hstats: \(hStats)")
                        self.healthData = hStats
                    }
                }
            }
                
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
