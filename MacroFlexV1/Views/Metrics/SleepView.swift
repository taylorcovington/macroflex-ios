//
//  SleepView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 7/21/23.
//

import SwiftUI

struct SleepView: View {
    // Replace this array with your actual sleep data retrieved from HealthKit
//    let sleepStats: [HealthStat] = [] // Your array of HealthStat objects goes here
    
    @ObservedObject var viewModel = DashboardViewModel.shared
    
    var body: some View {
        VStack {
            Text("Sleep Data for Last 7 Days")
                .font(.title)
                .padding()
            
            List {
                ForEach(aggregatedSleepDataForLast7Days(), id: \.self) { sleepEntry in
                    SleepEntryView(sleepEntry: sleepEntry)
                }
            }
        }
    }
    
    func aggregatedSleepDataForLast7Days() -> [SleepEntry] {
        // Filter sleep data for the last 7 days
        let last7Days = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let filteredData = viewModel.sleepStats.filter { $0.date >= last7Days }
        
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
}

struct SleepEntryView: View {
    let sleepEntry: SleepEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Date: \(formattedDate)")
            Text("Total Sleep Duration: \(formattedDuration)")
        }
        .padding()
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: sleepEntry.date)
    }
    
    var formattedDuration: String {
           let hours = Int(sleepEntry.totalSleepDuration / 3600)
           let minutes = Int((sleepEntry.totalSleepDuration.truncatingRemainder(dividingBy: 3600)) / 60)
           return String(format: "%dh %dm", hours, minutes)
       }
}

struct SleepEntry: Hashable {
    let date: Date
    let totalSleepDuration: Double
}

struct SleepView_Previews: PreviewProvider {
    static var previews: some View {
        SleepView()
    }
}
