//
//  WeightTrackingView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import SwiftUI
import Charts

struct WeightTrackingView: View {
    @ObservedObject var viewModel = DashboardViewModel(activity: Activity.allActivities()[1])
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Image("weightscale")
                    .resizable()
                    .frame(width: 100, height: 100)
                 
                Text("\(viewModel.todaysWeight, specifier: "%.1f")")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                Text("of 155 goal")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(25)
            .padding(10)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            VStack(alignment: .leading){
                
                HStack(alignment: .bottom) {
    //                TODO: What if a user only has one day? need to change the 7 to a length of the array
                    Text("\(viewModel.healthData.reduce(0, { $0 + $1.stat! }) / 7, specifier: "%.1f")")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text("average last 7 days")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                }
                Chart {
    //                TODO: Update this with users actual goal
                    RuleMark(y: .value("Goal", 155))
                        .foregroundStyle(Color.mint)
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
    //                    .annotation(alignment: .leading) {
    //                        Text("Goal")
    //                            .font(.caption)
    //                            .foregroundColor(.secondary)
    //                    }
                    ForEach(viewModel.healthData) { step in
                        LineMark(
                            x: .value("Date", step.date, unit: .day),
                            y: .value("Weight", step.stat ?? 0)
                        )
                        .foregroundStyle(Color(Colors.mfBluePrimary).gradient)
                    }
                }
                .frame(height: 200)
//                .chartYScale(domain: 150...160)
                .chartXAxis {
                    AxisMarks(values: viewModel.healthData.map { $0.date }) { date in
                        AxisValueLabel(format: .dateTime.day(), centered: true)
                    }
                }
                .padding(.bottom)
                
                HStack {
                    Image(systemName: "line.diagonal")
                        .rotationEffect(Angle(degrees: 45))
                        .foregroundColor(.mint)
                    Text("Goal")
                        .foregroundColor(.secondary)
                }
                
//            MARK: Start of list
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Weight logs")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .padding()
                            
                            ForEach(viewModel.healthData) { step in
                                HStack {
                                    Text("\(step.date.displayFormat)")
                                    Spacer()
                                    Text("\(step.stat ?? 0, specifier: "%.1f")")
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                    Text("steps")
                                        .font(.system(size: 12, weight: .regular, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
            }
            .navigationBarTitle("Weight Logs")
        .padding()
        }
    }
}

struct WeightTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        WeightTrackingView()
    }
}
